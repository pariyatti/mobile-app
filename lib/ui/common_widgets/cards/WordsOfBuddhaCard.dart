import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/audio_button.dart';
import 'package:patta/ui/common_widgets/bookmark_button.dart';
import 'package:patta/ui/common_widgets/share_button.dart';
import 'package:patta/ui/model/WordsOfBuddhaCardModel.dart';
import 'package:patta/util.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WordsOfBuddhaCard extends StatefulWidget {
  final WordsOfBuddhaCardModel data;
  final PariyattiDatabase database;

  WordsOfBuddhaCard(this.data, this.database, {Key? key}) : super(key: key);

  @override
  _WordsOfBuddhaCardState createState() => _WordsOfBuddhaCardState();
}

class _WordsOfBuddhaCardState extends State<WordsOfBuddhaCard> {
  final GlobalKey _renderKey = new GlobalKey();
  final _player = AudioPlayer();
  bool _translationVisible = false;
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
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    initAudioSource();
    initLanguage();
    super.initState();
  }

  Future<void> initAudioSource() async {
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(widget.data.audioUrl ?? "")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  void initLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = Language.from(prefs.getString(Language.SETTINGS_KEY));
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void playStop() async {
    // TODO: toggle play vs. stop depending on player state
    _player.seek(Duration.zero); // needed in case the audio has played once
    _player.play();
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
                    buildHeader(),
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

  Padding buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      child: Text(
        widget.data.header?.toUpperCase() ?? "<header was empty>",
        style: TextStyle(
          inherit: true,
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  buildOverlayWords() {
    var pali = Text(widget.data.words ?? "<words field was empty>",
      // TODO: what is the correct font, here?
      style: GoogleFonts.getFont('Noto Serif', textStyle:
      TextStyle(
        inherit: true,
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFF000000))
      ),
    );
    var eng = Text(widget.data.translations![_selectedLanguage.code] ?? "<translation was empty>",
        // TODO: what is the correct font, here?
        style: GoogleFonts.getFont('Noto Serif', textStyle:
        TextStyle(
            inherit: true,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000))
        )
    );
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
                child: Image.asset("assets/images/quote-bg-light-700px.png", fit: BoxFit.fitWidth)
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
                      child: pali,
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
                    child: eng,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildButtonFooter() {
    return Container(
      color: Color(0xffdcd3c0),
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
    return AudioButton(
      onPressed: loaded == true ? () async {
        playStop();
      } : null,
    );
  }

  ShareButton buildShareButton() {
    return ShareButton(onPressed: loaded == true ? () async {
      Uint8List imageData = await _getImage();
      final String extension = extractFileExtension(widget.data.imageUrl);
      await WcFlutterShare.share(
        sharePopupTitle: AppStrings.get().labelShareInspiration,
        mimeType: 'image/$extension',
        fileName: '${widget.data.header}.$extension',
        bytesOfFile: imageData,
        text: widget.data.words,
        );
    } : null);
  }

  Visibility buildBookmarkButton() {
    return Visibility(visible: widget.data.isBookmarkable,
                      child: BookmarkButton(widget.data, widget.database));
  }

}
