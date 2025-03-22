import 'dart:convert';
import 'package:brain_curve/Model/youtube.dart';
import 'package:brain_curve/base_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Helper/internet_checker.dart';
import '../Helper/showSnackbar.dart';
import '../Utils/colorful.dart';
import 'package:http/http.dart' as http;

class RecommendedVideoProvider extends ChangeNotifier {
  static final RecommendedVideoProvider _instance =
      RecommendedVideoProvider._internal();

  factory RecommendedVideoProvider() {
    return _instance;
  }

  RecommendedVideoProvider._internal();

  List<VideoModel> _videos = [];
  bool _isLoading = false;

  List<VideoModel> get videos => _videos;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set videos(List<VideoModel> videosData) {
    _videos = videosData;
    notifyListeners();
  }

  Future<void> fetchVideos(BuildContext context) async {
    if (isLoading) return;
    bool result = await checkInternetConnection();
    if (result == false) {
      showSnackBar(
          "No internet connection, please check your internet connectivity and try again!",
          context,
          bgColor: Colors.red);
      return;
    }

    isLoading = true;
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/content/abc'));
      if (response.statusCode == 200) {
        Map<String,dynamic> data = json.decode(response.body);
       List<dynamic> videoList=data["videos"];

        videos = videoList.map((video) => VideoModel.fromJson(video)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      printRed("Error fetching users: $e");
    } finally {
      isLoading = false;
    }
  }
}
