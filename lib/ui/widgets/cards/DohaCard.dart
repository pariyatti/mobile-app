import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/ui/common/audio_button.dart';
import 'package:patta/ui/common/bookmark_button.dart';
import 'package:patta/ui/common/card_header.dart';
import 'package:patta/ui/common/share_button.dart';
import 'package:patta/model/DohaCardModel.dart';
import 'package:patta/app/style.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/util.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DohaCard extends StatefulWidget {
  final DohaCardModel data;
  final PariyattiDatabase database;

  DohaCard(this.data, this.database, {Key? key}) : super(key: key);

  @override
  _DohaCardState createState() => _DohaCardState();
}

class _DohaCardState extends State<DohaCard> {
  final GlobalKey _renderKey = new GlobalKey();
  bool _translationVisible = true;
  late Uri _audioUrl;
  Language _selectedLanguage = Language.eng;
  late bool loaded;

  Future<Uint8List> _getImage() async {
    try {
      RenderRepaintBoundary boundary =
          _renderKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      var pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void initState() {
    // Check if image is in cache in case widget gets rebuilt and the onLoaded callback doesn't respond.
    loaded = DefaultCacheManager().getFileFromMemory(widget.data.imageUrl!) != null;
    initAudioUrl();
    initLanguage();
    super.initState();
  }

  void initAudioUrl() {
    try {
      _audioUrl = Uri.parse(widget.data.audioUrl ?? "");
    } catch (e) {
      print("Error parsing audio URL: $e");
    }
  }

  void initLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = Language.from(prefs.getString(Language.SETTINGS_KEY));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
              ),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CardHeader(context, widget.data.header ?? I18n.get("dhammaVerse")),
                    buildOverlayWords(),
                    buildButtonFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildOverlayWords() {
    return RepaintBoundary(
      key: _renderKey,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Align(alignment: Alignment.bottomRight,
                child: AppThemes.quoteBackground(context)
              )
            )
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Visibility(
                  visible: loaded,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _translationVisible = !_translationVisible;
                        });
                      },
                      child: getPaliText(),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Visibility(
                  visible: _translationVisible,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: getTranslationText(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text getTranslationText() => Text(getTranslation(), style: serifFont(context: context));
  String getTranslation() => widget.data.translations![_selectedLanguage.code] ?? "<translation ${I18n.get("wasEmpty")}>";

  Text getPaliText() => Text(getPali(), style: serifFont(context: context));
  String getPali() => widget.data.doha ?? "<words field ${I18n.get("wasEmpty")}>";

  Container buildButtonFooter() {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildAudioButton(),
          buildBookmarkButton(),
          buildShareButton()
        ],
      ),
    );
  }

  AudioButton buildAudioButton() {
    return AudioButton(audioUrl: _audioUrl);
  }

  ShareButton buildShareButton() {
    return ShareButton(onPressed: loaded == true ? () async {
      Uint8List imageData = await _getImage();
      final String filename = toFilename(widget.data.header!);
      final String extension = extractFileExtension(widget.data.imageUrl);
      await WcFlutterShare.share(
        sharePopupTitle: I18n.get("shareInspiration"),
        mimeType: 'image/$extension',
        fileName: '$filename.$extension',
        bytesOfFile: imageData
        // // if we exclude this, everything tries to share the images instead:
        // ,text: getPali() + "\n\n" + getTranslation()
      );
    } : null);
  }

  Visibility buildBookmarkButton() {
    return Visibility(visible: widget.data.isBookmarkable,
                      child: BookmarkButton(widget.data, widget.database));
  }

}
