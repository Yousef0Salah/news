// import 'package:flutter/material.dart';
// import 'package:news/core/categoreis/app_categoreis.dart';
// import 'package:news/module/layout/data/models/news_response.dart';
// import 'package:news/module/layout/data/models/sources_response.dart';
// import 'package:news/module/layout/data/repo/repo.dart';

// class LayoutProvider extends ChangeNotifier {
//   List<Sources>? sources = [];
//   List<Articles>? articles = [];

//   AppCategoreis? selectedCategory;
//   Sources? selectedsource;

//   bool isLoading = false;

//   Repo repo = RepoImp();

//   void onChangeCategoty(AppCategoreis category) {
//     selectedCategory = category;
//     getSources();
//     notifyListeners();
//   }

//   void goToHome() {
//     selectedCategory = null;
//     selectedsource = null;
//     sources = [];
//     // articles = [];
//     notifyListeners();
//   }

//   void onChangeSources(Sources sources) {
//     selectedsource = sources;
//     articles = [];
//     getNews();
//     notifyListeners();
//   }

//   Future<void> getSources() async {
//     isLoading = true;
//     try {
//       sources = await repo.getSource(selectedCategory!.id);
//       selectedsource = sources!.first;
//       // getNews();
//     } catch (e) {
//       getNews();
//       print(e.toString());
//     }
//     isLoading = false;
//     notifyListeners();
//   }

//   Future<void> getNews() async {
//     try {
//       articles = await repo.getNews(selectedsource!.id!);
//     } catch (e) {
//       print(e.toString());
//     }
//     notifyListeners();
//   }
// }
