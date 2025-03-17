import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class VimeoPlayerScreen extends StatelessWidget {
  final String videoId;

  const VimeoPlayerScreen({required this.videoId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.file_upload_outlined, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              // Implement download functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark_outline_outlined, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              // Implement bookmark functionality here
            },
          ),
        ],
      ),
      body: VimeoPlayer(videoId: this.videoId),
    );
  }
}



