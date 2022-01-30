import 'package:flutter/material.dart';
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';
import 'package:just_audio/just_audio.dart';

class AudioButton extends StatefulWidget {
  final Uri? audioUrl;

  AudioButton({this.audioUrl, Key? key}) : super(key: key);

  @override
  _AudioButtonState createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  final _player = AudioPlayer();

  @override
  void initState() {
    initStreamListen();
    initAudioSource();
    super.initState();
  }

  void initStreamListen() {
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
  }

  Future<void> initAudioSource() async {
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(AudioSource.uri(widget.audioUrl!));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var icon = _player.playing ? PariyattiIcons.get(IconName.stop) : PariyattiIcons.get(IconName.play);
    return Expanded(
      child: MaterialButton(
        padding: EdgeInsets.zero,
        child: Icon(icon, color: Color(0xff6d695f)),
        onPressed: playStop,
      ),
    );
  }

  void playStop() async {
    return _player.playing ? stop() : play();
  }

  void play() {
    _player.seek(Duration.zero); // needed in case the audio has played once
    setState(() { _player.play(); });
  }

  void stop() {
    setState(() { _player.stop(); });
    _player.seek(Duration.zero);
  }
}