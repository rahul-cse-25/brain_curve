import 'package:brain_curve/Extension/theme.dart';
import 'package:brain_curve/Model/youtube.dart';
import 'package:brain_curve/Provider/recommended_videos.dart';
import 'package:brain_curve/Screens/video_detail.dart';
import 'package:brain_curve/Utils/customize_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Provider/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String profilePic = '';
  String userName = 'Guest Student';
  String appName = "BrainCurve";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.containerColor,
        statusBarIconBrightness:
            context.isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            BrainCurveCustomizeStyle style =
                BrainCurveCustomizeStyle.init(constraints, orientation);
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                backgroundColor: context.backgroundColor,
                body: SafeArea(
                  child: Column(
                    children: [
                      // appbar
                      Container(
                        color: context.containerColor,
                        child: Padding(
                          padding: style.brainCurveAllScreenPadding(ver: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom:
                                          style.sizes.verticalBlockSize * 0.8,
                                      left: style.sizes.horizontalBlockSize * 7,
                                      child: Text(
                                        userName,
                                        style: TextStyle(
                                            color: Color(0xff495057),
                                            fontSize:
                                                style.sizes.textMultiplier *
                                                    1.2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          appName.substring(0, 1),
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontSize:
                                                  style.sizes.textMultiplier *
                                                      4.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: Colors.deepPurpleAccent,
                                          highlightColor:
                                              context.backgroundColor,
                                          period: Duration(seconds: 5),
                                          child: Text(
                                            appName.substring(1),
                                            style: TextStyle(
                                                color: const Color(0xff7209b7)
                                                    .withValues(alpha: 0.8),
                                                fontSize:
                                                    style.sizes.textMultiplier *
                                                        2.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Consumer<HomeProvider>(
                                builder: (context, menuProvider, child) {
                                  return PopupMenuButton<String>(
                                    padding: EdgeInsets.zero,
                                    color: Colors.deepPurpleAccent,

                                    elevation: 2,
                                    // Gives the popup a shadow effect
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          style.sizes.horizontalBlockSize *
                                              6), // Rounded corners
                                    ),
                                    popUpAnimationStyle: AnimationStyle(
                                        curve: Curves.slowMiddle,
                                        duration:
                                            const Duration(milliseconds: 200)),
                                    offset: Offset(
                                      style.sizes.horizontalBlockSize * 4.0,
                                      style.sizes.horizontalBlockSize * 12,
                                    ),
                                    onOpened: () =>
                                        menuProvider.toggleMenu(true),
                                    onCanceled: () =>
                                        menuProvider.toggleMenu(false),
                                    onSelected: (value) async {
                                      if (value == "Light" || value == "Dark") {
                                        menuProvider.toggleMenu(false);
                                        context.toggleTheme();
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return {
                                        context.isDarkMode ? "Light" : "Dark",
                                        "All Users",
                                        "About me",
                                      }.map((String popListChoice) {
                                        return PopupMenuItem<String>(
                                          padding:
                                              style.brainCurveAllScreenPadding(
                                                  ver: 2, hor: 3),
                                          value: popListChoice,
                                          child: Row(
                                            children: [
                                              Icon(
                                                popListChoice == "All Users"
                                                    ? Icons.person
                                                    : popListChoice ==
                                                            "About me"
                                                        ? Icons.info
                                                        : context.isDarkMode
                                                            ? Icons.light_mode
                                                            : Icons.dark_mode,
                                                color: Colors.white,
                                                size:
                                                    style.sizes.textMultiplier *
                                                        2.5,
                                              ),
                                              style.brainCurveHorizontalGap(
                                                  horizontalGapSizeInPercent:
                                                      2.0),
                                              Text(popListChoice,
                                                  style: style.subHeaderStyle(
                                                      color: Colors.white,
                                                      size: 1.5 *
                                                          style.sizes
                                                              .textMultiplier)),
                                            ],
                                          ),
                                        );
                                      }).toList();
                                    },
                                    splashRadius: 0,
                                    child: Container(
                                      padding: style.brainCurveAllScreenPadding(
                                          ver: 1, hor: 1),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            style.sizes.screenWidth),
                                        color: Colors.grey.shade300,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withValues(
                                                  alpha: context.isDarkMode
                                                      ? 0.7
                                                      : 0.3),
                                              spreadRadius: 2,
                                              // blurRadius: 7,
                                              blurStyle: BlurStyle
                                                  .inner // changes position of shadow
                                              ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          if (menuProvider.isMenuOpened)
                                            style.brainCurveHorizontalGap(
                                                horizontalGapSizeInPercent: 1),
                                          if (!menuProvider.isMenuOpened)
                                            _buildProfileIcon(style),
                                          if (menuProvider.isMenuOpened)
                                            _buildMenuBarIcon(style),
                                          style.brainCurveHorizontalGap(
                                              horizontalGapSizeInPercent: 1),
                                          if (menuProvider.isMenuOpened)
                                            _buildProfileIcon(style),
                                          if (!menuProvider.isMenuOpened)
                                            _buildMenuBarIcon(style),
                                          if (!menuProvider.isMenuOpened)
                                            style.brainCurveHorizontalGap(
                                                horizontalGapSizeInPercent: 1),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      // main body
                      Expanded(
                        child: LiquidPullToRefresh(
                          onRefresh: () =>
                              RecommendedVideoProvider().fetchVideos(context),
                          backgroundColor: Colors.white,
                          showChildOpacityTransition: false,
                          animSpeedFactor: 3.0,
                          springAnimationDurationInMilliseconds: 500,
                          height: style.sizes.screenHeight * 0.1,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [BrainCurve(), RecommendedVideos()],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProfileIcon(BrainCurveCustomizeStyle appStyle) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: appStyle.sizes.textMultiplier * 4,
          maxWidth: appStyle.sizes.textMultiplier * 4),
      decoration: BoxDecoration(
          color:
              profilePic.isEmpty ? Colors.deepPurpleAccent : Colors.transparent,
          image: profilePic.isEmpty
              ? null
              : DecorationImage(
                  image: NetworkImage(profilePic), fit: BoxFit.cover),
          shape: BoxShape.circle),
      child: profilePic.isNotEmpty
          ? null
          : Center(
              child: Icon(
              Icons.person,
              color: Colors.white,
              size: appStyle.sizes.textMultiplier * 3.0,
            )),
    );
  }

  Widget _buildMenuBarIcon(BrainCurveCustomizeStyle appStyle) {
    return Icon(
      Icons.menu,
      size: appStyle.sizes.textMultiplier * 3,
      color: Colors.grey,
    );
  }
}

class BrainCurve extends StatelessWidget {
  BrainCurve({super.key});

  final BrainCurveCustomizeStyle style = BrainCurveCustomizeStyle();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: style.brainCurveAllScreenPadding(ver: 1),
      decoration: BoxDecoration(
        color: context.containerColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(style.sizes.horizontalBlockSize * 12),
          bottomRight: Radius.circular(style.sizes.horizontalBlockSize * 12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          style.brainCurveVerticalGap(verticalGapSizeInPercent: 0.5),
          Text(
            "Hello Steven,",
            style: TextStyle(
                color: context.backgroundColor,
                fontSize: style.sizes.textMultiplier * 2.5,
                fontWeight: FontWeight.bold),
          ),
          style.brainCurveVerticalGap(verticalGapSizeInPercent: 2),
          Row(
            spacing: style.sizes.horizontalBlockSize * 2,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatBox("6541", "Steps", context),
              _buildStatBox("1.5", "Liters", context),
              _buildStatBox("259", "Cal Burn", context),
            ],
          ),
          style.brainCurveVerticalGap(verticalGapSizeInPercent: 2),
          Center(
            child: Text(
              "View Details",
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: style.sizes.textMultiplier * 2.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          style.brainCurveVerticalGap(verticalGapSizeInPercent: 1),
        ],
      ),
    );
  }

  Widget _buildStatBox(String value, String label, BuildContext context) {
    return Expanded(
      child: Container(
        // width: style.sizes.screenWidth*0.26,
        padding: style.brainCurveAllScreenPadding(ver: 3),

        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius:
              BorderRadius.circular(style.sizes.horizontalBlockSize * 5),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                  color: context.textColor,
                  fontSize: style.sizes.textMultiplier * 2.5,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: style.sizes.textMultiplier * 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedVideos extends StatefulWidget {
  const RecommendedVideos({super.key});

  @override
  State<RecommendedVideos> createState() => _RecommendedVideosState();
}

class _RecommendedVideosState extends State<RecommendedVideos> {
  final BrainCurveCustomizeStyle style = BrainCurveCustomizeStyle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: style.brainCurveAllScreenPadding(ver: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recommended Videos",
                  style: style.subHeaderStyle(
                      color: context.containerColor,
                      fontWeight: FontWeight.bold,
                      size: style.sizes.textMultiplier * 2.4)),
              Text("View All",
                  style: style.subHeaderStyle(
                      color: Colors.deepPurpleAccent,
                      size: style.sizes.textMultiplier * 2)),
            ],
          ),

          Consumer<RecommendedVideoProvider>(
            builder: (context, videos, child) {
              return videos.videos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // style.offiqlLottieImage(
                          //     'assets/json/no_data.json',
                          //     widthInPercent: 100),
                          Padding(
                            padding: style.brainCurveAllScreenPadding(),
                            child: Text(
                              "No Video found, Please pull to refresh.",
                              textAlign: TextAlign.center,
                              style: context.textTheme.headlineSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: videos.videos.length,
                      itemBuilder: (context, index) {
                        VideoModel video = videos.videos[index];
                        return _buildChallengeCard(video);
                      },
                    );
            },
          )
        ],
      ),
    );
  }

  Widget _buildChallengeCard(VideoModel videoModel) {
    return Padding(
      padding: style.brainCurveAllScreenPadding(hor: 0, ver: 2),
      child: Hero(
        tag: videoModel.videoId,
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius:
              BorderRadius.circular(style.sizes.horizontalBlockSize * 6),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  minWidth: style.sizes.screenWidth,
                  minHeight: style.sizes.screenHeight * 0.2,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(videoModel.thumbnail),
                      fit: BoxFit.cover),
                ),
              ),

              // Text Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: style.brainCurveAllScreenPadding(ver: 1, hor: 2),
                    child: Text(videoModel.title,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: style.subHeaderStyle(color: Colors.black)),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoDetail(videoModel: videoModel),
                        )),
                    child: Container(
                      padding: style.brainCurveAllScreenPadding(ver: 2, hor: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            style.sizes.horizontalBlockSize * 8),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.white],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
