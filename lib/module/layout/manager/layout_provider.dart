import 'package:flutter/material.dart';
import 'package:news/core/categoreis/app_categoreis.dart';
import 'package:news/module/layout/models/news_response.dart';
import 'package:news/module/layout/models/sources_response.dart';
import 'package:news/module/layout/service/api_manager.dart';

class LayoutProvider extends ChangeNotifier {
  List<Sources>? sources = [];
  List<Articles>? articles = [];

  AppCategoreis? selectedCategory;
  Sources? selectedsource;

  bool isLoading = false;

  void onChangeCategoty(AppCategoreis category) {
    selectedCategory = category;
    getSources();
    notifyListeners();
  }

  void goToHome() {
    selectedCategory = null;
    selectedsource = null;
    sources = [];
    notifyListeners();
  }

  void onChangeSources(Sources sources) {
    selectedsource = sources;
    articles = [];
    getNews();
    notifyListeners();
  }

  Future<void> getSources() async {
    isLoading = true;
    try {
      sources = await ApiManager.getSource(selectedCategory!.id);
      selectedsource = sources!.first;
      getNews();
    } catch (e) {
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getNews() async {
    try {
      articles = await ApiManager.getNews(selectedsource!.id!);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
