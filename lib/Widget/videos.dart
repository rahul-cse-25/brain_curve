import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Uri videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(widget.videoUrl);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return _controller.value.isInitialized
  //       ? Stack(
  //           alignment: Alignment.center,
  //           children: [
  //             AspectRatio(
  //               aspectRatio: _controller.value.aspectRatio,
  //               child: VideoPlayer(_controller),
  //             ),
  //             // IconButton(
  //             //   icon: Icon(
  //             //     _controller.value.isPlaying
  //             //         ? Icons.pause
  //             //         : Icons.play_arrow,
  //             //     color: Colors.white,
  //             //     size: 40,
  //             //   ),
  //             //   onPressed: () {
  //             //     setState(() {
  //             //       _controller.value.isPlaying
  //             //           ? _controller.pause()
  //             //           : _controller.play();
  //             //     });
  //             //   },
  //             // ),
  //           ],
  //         )
  //       : CircularProgressIndicator();
  // }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }
}
