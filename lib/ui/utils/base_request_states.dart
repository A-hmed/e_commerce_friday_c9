import 'package:e_commerce_friday_c9/data/model/api/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_response.dart';

abstract class BaseRequestStates {}

class BaseRequestInitialState extends BaseRequestStates {}

class BaseRequestLoadingState extends BaseRequestStates {}

class BaseRequestSuccessState<Type> extends BaseRequestStates {
  Type? data;

  BaseRequestSuccessState({this.data});
}

class BaseRequestErrorState extends BaseRequestStates {
  String message;

  BaseRequestErrorState(this.message);
}
