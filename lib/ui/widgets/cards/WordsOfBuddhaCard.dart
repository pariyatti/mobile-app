import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:patta/app/log.dart';
import 'package:patta/app/preferences.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/model/Chanting.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/ui/common/audio_button.dart';
import 'package:patta/ui/common/bookmark_button.dart';
import 'package:patta/ui/common/card_header.dart';
import 'package:patta/ui/common/info_button.dart';
import 'package:patta/ui/common/share_button.dart';
import 'package:patta/model/WordsOfBuddhaCardModel.dart';
import 'package:patta/app/style.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/ui/common/shared_image.dart';
import 'package:patta/ui/common/toggle.dart';
import 'package:url_launcher/link.dart';
import 'package:share_plus/share_plus.dart';

class WordsOfBuddhaCard extends StatefulWidget {
  final WordsOfBuddhaCardModel data;
  final PariyattiDatabase database;

  WordsOfBuddhaCard(this.data, this.database, {Key? key}) : super(key: key);

  @override
  _WordsOfBuddhaCardState createState() => _WordsOfBuddhaCardState();
}

class _WordsOfBuddhaCardState extends State<WordsOfBuddhaCard> {
  final GlobalKey _renderKey = new GlobalKey();
  bool _translationVisible = true;
  Toggle _citationToggle = new Toggle(isActive: false);
  late Chanting _chanting;
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
      _chanting = new Chanting(Uri.parse(widget.data.audioUrl ?? ""));
      // TODO: expose both audio URLs to Chanting + AudioButton so it can play the backup
      // _chanting = new Chanting(Uri.parse(widget.data.kosaAudio?.url ?? ""));
    } catch (e) {
      print("${I18n.get("error")} parsing audio URL: $e");
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
                    CardHeader(context, I18n.get("words_of_the_buddha"), Theme.of(context).colorScheme.surface),
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
                      child: GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            _chanting = _chanting.tryToggle();
                          });
                          log2("Discourse chanting toggled by double-tap: ${_chanting.isSpecialVisible}");
                        },
                        child: getTranslationText(),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Visibility(
                    visible: _citationToggle.isActive,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: getCitationText(),
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

  Text getPaliText() => Text(getPali(), style: serifFont(context: context));
  String getPali() => widget.data.words ?? "<words field ${I18n.get("was_empty")}>";

  Text getTranslationText() => Text(getTranslation(), style: serifFont(context: context));
  String getTranslation() => widget.data.translations![_selectedLanguage.code] ?? "<translation ${I18n.get("was_empty")}>";

  Widget getCitationText() {
    if (widget.data.citepali == null && widget.data.citebook == null) {
      return Text("<citation ${I18n.get("was_empty")}>", style: serifFont(context: context));
    }
    return Column(children: <Widget>[
      Align(alignment: Alignment.topLeft,
          child: Link(
            uri: Uri.parse(widget.data.citepali_url ?? ""),
            builder: (context, followLink) {
              return InkWell(
                onTap: followLink,
                child: Text(widget.data.citepali ?? "", style: serifFont(context: context)));
            },
          ),
      ),
      Align(alignment: Alignment.topLeft,
        child: Link(
          uri: Uri.parse(widget.data.citebook_url ?? ""),
          builder: (context, followLink) {
            return InkWell(
                onTap: followLink,
                child: Text(widget.data.citebook ?? "", style: serifFont(context: context)));
          },
        ),
      ),
    ]);
  }

  Container buildButtonFooter() {
    log2("Rebuilding button footer");
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        // TODO: this funkage with Visibility can be replaced with a Toggle -sd
        children: <Widget>[
          Visibility(
            visible: !_chanting.isSpecialVisible,
            child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildAudioButton(_chanting.audioUrl),
              buildInfoButton(),
              buildBookmarkButton(),
              buildShareButton()
            ],
          ),),
          Visibility(
            visible: _chanting.isSpecialVisible,
            child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildAudioButton(_chanting.specialUrl, Theme.of(context).colorScheme.onSurfaceVariant),
              buildInfoButton(),
              buildBookmarkButton(),
              buildShareButton()
            ],
          ),),
        ],
      ),
    );
  }

  AudioButton buildAudioButton(Uri? url, [Color? color]) {
    log2("Audio button URL is: $url");
    return AudioButton(audioUrl: url, overrideColor: color);
  }

  ShareButton buildShareButton() {
    return ShareButton(onPressed: loaded == true ? () async {
      // (((_renderKey.currentWidget as RepaintBoundary).child as Container).decoration as BoxDecoration).color = Theme.of(context).colorScheme.surface;
      Uint8List bytes = await SharedImage.getBytesFromRenderKey(_renderKey);
      SharedImage img = SharedImage(bytes, I18n.get("words_of_the_buddha"), widget.data.imageUrl);
      await Share.shareXFiles(
          [await img.toXFile()],
          subject: I18n.get("share_words_of_buddha"));
    } : null);
  }

  Visibility buildBookmarkButton() {
    return Visibility(visible: widget.data.isBookmarkable,
                      child: BookmarkButton(widget.data, widget.database));
  }

  InfoButton buildInfoButton() {
    return InfoButton(toggle: _citationToggle, onPressed: () { setState(() {}); });
  }

}
