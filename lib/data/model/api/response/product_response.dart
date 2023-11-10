import 'package:e_commerce_friday_c9/data/model/api/response/base_response.dart';

import 'metadata.dart';
import 'product_dm.dart';

class ProductResponse extends BaseResponse {
  int? results;
  Metadata? metadata;
  List<ProductDM>? data;

  ProductResponse({this.results, this.metadata, this.data});

  ProductResponse.fromJson(dynamic json) {
    results = json["results"];
    message = json["message"];
    metadata =
        json["metadata"] != null ? Metadata.fromJson(json["metadata"]) : null;
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(ProductDM.fromJson(v));
      });
    }
  }
}
