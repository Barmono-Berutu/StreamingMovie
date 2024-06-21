import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VidioPlay extends StatefulWidget {
  const VidioPlay({super.key, required this.youtubeKey, required this.name});

  final String youtubeKey;
  final String name;

  @override
  State<VidioPlay> createState() => _VidioPlayState();
}

class _VidioPlayState extends State<VidioPlay> {
  late final YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: YoutubePlayerBuilder(
        onEnterFullScreen: () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ]);
        },
        onExitFullScreen: () {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: [
              SystemUiOverlay.bottom,
              SystemUiOverlay.top,
            ],
          );
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
        },
        player: YoutubePlayer(controller: _controller),
        builder: (_, player) => player,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
