import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:patta/app/preferences.dart';
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
import 'package:share_plus/share_plus.dart';

import '../../common/shared_image.dart';

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
  late Uri _originalAudioUrl;
  Language _selectedLanguage = Language.eng;
  late bool loaded;

  @override
  void initState() {
    // Check if image is in cache in case widget gets rebuilt and the onLoaded callback doesn't respond.
    // ignore: unnecessary_null_comparison
    loaded = DefaultCacheManager().getFileFromMemory(widget.data.imageUrl!) != null;
    initAudioUrl();
    initLanguage();
    super.initState();
  }

  void initAudioUrl() {
    try {
      _originalAudioUrl = Uri.parse(widget.data.audioUrl ?? "");
      // TODO: expose both audio URLs to AudioButton so it can play the backup
      // _audioUrl = Uri.parse(widget.data.kosaAudio?.url ?? "");
    } catch (e) {
      print("Error parsing audio URL: $e");
    }
  }

  void initLanguage() async {
    setState(() {
      _selectedLanguage = Preferences.getLanguage(Language.SETTINGS_KEY);
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
                    CardHeader(context, I18n.get("dhamma_verse"), Theme.of(context).colorScheme.surface),
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
      child: Container(decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child:
        Stack(
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
      ),
    );
  }

  Text getTranslationText() => Text(getTranslation(), style: serifFont(context: context));
  String getTranslation() => widget.data.translations![_selectedLanguage.code] ?? "<translation ${I18n.get("was_empty")}>";

  Text getPaliText() => Text(getPali(), style: serifFont(context: context));
  String getPali() => widget.data.doha ?? "<words field ${I18n.get("was_empty")}>";

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
    return AudioButton(audioUrl: _originalAudioUrl);
  }

  ShareButton buildShareButton() {
    return ShareButton(onPressed: loaded == true ? () async {
      Uint8List bytes = await SharedImage.getBytesFromRenderKey(_renderKey);
      SharedImage img = SharedImage(bytes, I18n.get("dhamma_verse"), widget.data.imageUrl);
      await Share.shareXFiles(
          [await img.toXFile()],
          subject: I18n.get("share_dhamma_verse"));
    } : null);
  }

  Visibility buildBookmarkButton() {
    return Visibility(visible: widget.data.isBookmarkable,
                      child: BookmarkButton(widget.data, widget.database));
  }

}
