import 'package:e_commerce_friday_c9/data/model/api/response/base_response.dart';

import 'cart_dm.dart';

class CartResponse extends BaseResponse {
  String? status;
  int? numOfCartItems;
  CartDM? data;

  CartResponse({this.status, this.numOfCartItems, this.data});

  CartResponse.fromJson(dynamic json) {
    status = json["status"];
    message = json["message"];
    numOfCartItems = json["numOfCartItems"];
    data = json["data"] != null ? CartDM.fromJson(json["data"]) : null;
  }
}
