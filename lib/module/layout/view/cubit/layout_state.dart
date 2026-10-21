sealed class LayoutState {}

class InitState extends LayoutState {}

class GoToHome extends LayoutState {}

class ChangeCategoty extends LayoutState {}

class ChangeSources extends LayoutState {}

class GetSourcesLoadingState extends LayoutState {}

class GetSourcesSuccessState extends LayoutState {}

class GetSourcesErrorState extends LayoutState {
  String error;
  GetSourcesErrorState({required this.error});
}

class GetNewsLoadingState extends LayoutState {}

class GetNewsSuccessState extends LayoutState {}

class GetNewsErrorState extends LayoutState {
  String error;
  GetNewsErrorState({required this.error});
}
