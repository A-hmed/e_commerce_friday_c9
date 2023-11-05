

class BaseInitialState {}

class BaseLoadingState {}

class BaseErrorState {
  String errorMessage;

  BaseErrorState(this.errorMessage);
}

class BaseSuccessState<Type> {
  List<Type>? data;

  BaseSuccessState({this.data});
}
