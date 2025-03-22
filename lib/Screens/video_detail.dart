import 'package:brain_curve/Extension/theme.dart';
import 'package:brain_curve/Model/youtube.dart';
import 'package:brain_curve/Utils/customize_style.dart';
import 'package:brain_curve/Widget/videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.backgroundColor,
        statusBarIconBrightness:
            context.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: style.brainCurveIcon(
              Icons.arrow_back,
              color: context.textColor,
            ),
          ),
          title: Text(
            'Video Details',
            style: style.subHeaderStyle(
              size: style.sizes.textMultiplier * 2.5,
              fontWeight: FontWeight.bold,
              color: context.textColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: context.backgroundColor,
          surfaceTintColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
              color: context.backgroundColor,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: style.brainCurveAllScreenPadding(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: style.sizes.horizontalBlockSize * 2,
                    children: [
                      Hero(
                          tag: widget.videoModel.videoId,
                          child: VideoPlayerWidget(
                              videoUrl: widget.videoModel.videoUrl)),
                      Text(widget.videoModel.title),
                      Text(widget.videoModel.description),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
