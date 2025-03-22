

import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  static final HomeProvider _instance = HomeProvider._internal();

  factory HomeProvider() {
    return _instance;
  }

  HomeProvider._internal();
bool _isLoading = false;
  bool _isMenuOpened = false;
  bool _isSearching = false;
  TextEditingController searchController = TextEditingController();



  bool get isSearching => _isSearching;


  bool get isLoading => _isLoading;

  bool get isMenuOpened => _isMenuOpened;

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  void toggleMenu(bool value) {
    _isMenuOpened = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

}
