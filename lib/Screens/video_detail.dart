import 'package:brain_curve/Model/youtube.dart';
import 'package:brain_curve/Utils/customize_style.dart';
import 'package:brain_curve/Widget/videos.dart';
import 'package:flutter/material.dart';

class VideoDetail extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetail({super.key, required this.videoModel});

  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  BrainCurveCustomizeStyle style = BrainCurveCustomizeStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Detail"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: style.sizes.horizontalBlockSize * 2,
        children: [
          VideoPlayerWidget(videoUrl: widget.videoModel.videoUrl),
          Text(widget.videoModel.title),
          Text(widget.videoModel.description)
        ],
      ),
    );
  }
}
