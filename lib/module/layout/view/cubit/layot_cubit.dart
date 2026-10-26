import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news/core/categoreis/app_categoreis.dart';
import 'package:news/module/layout/data/models/news_response.dart';
import 'package:news/module/layout/data/models/sources_response.dart';
import 'package:news/module/layout/data/repo/repo.dart';
import 'package:news/module/layout/view/cubit/layout_state.dart';

@injectable
class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit(this.repo) : super(InitState());

  List<Sources>? sources = [];
  List<Articles>? articles = [];
  List<Articles>? resultSearch = [];

  AppCategoreis? selectedCategory;
  Sources? selectedsource;

  TextEditingController search = TextEditingController();
  bool isSearch = false;

  Repo repo;

  void closeSearch() {
    _searchDebounce?.cancel();
    search.clear();
    resultSearch = [];
    isSearch = !isSearch;
    emit(ChangeSearchState());
  }

  void onChangeCategoty(AppCategoreis category) {
    selectedCategory = category;
    getSources();
    emit(ChangeCategoty());
  }

  void goToHome() {
    selectedCategory = null;
    selectedsource = null;
    sources = [];
    articles = [];
    emit(GoToHome());
  }

  void onChangeSources(Sources sources) {
    selectedsource = sources;
    articles = [];
    getNews();
    emit(ChangeSources());
  }

  Future<void> getSources() async {
    emit(GetSourcesLoadingState());
    try {
      sources = await repo.getSource(selectedCategory!.id);
      selectedsource = sources!.first;
      getNews();
      emit(GetSourcesSuccessState());
    } catch (e) {
      emit(GetSourcesErrorState(error: e.toString()));
      getNews();
    }
  }

  Future<void> getNews() async {
    emit(GetNewsLoadingState());
    try {
      articles = await repo.getNews(selectedsource?.id ?? '');
      emit(GetNewsSuccessState());
    } catch (e) {
      emit(GetNewsErrorState(error: e.toString()));
    }
  }

  Future<void> getResultSearch(String query) async {
    // final query = search.text.trim();

    if (query.trim().isEmpty) {
      resultSearch = [];
      emit(GetResultSearchSuccessState());
      return;
    }

    emit(GetResultSearchLoadingState());

    try {
      resultSearch = await repo.getResultSearch(query);
      emit(GetResultSearchSuccessState());
    } catch (e) {
      emit(GetResultSearchErrorState(error: e.toString()));
    }
  }

  Timer? _searchDebounce;

  void searchWithDebounce(String query) {
    _searchDebounce?.cancel();

    final value = query.trim();

    if (value.isEmpty) {
      resultSearch = [];
      emit(GetResultSearchSuccessState());
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      getResultSearch(value);
    });
  }
}
