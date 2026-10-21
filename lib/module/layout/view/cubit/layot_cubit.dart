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

  AppCategoreis? selectedCategory;
  Sources? selectedsource;

  bool isSearch = true;

  Repo repo;

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
}
