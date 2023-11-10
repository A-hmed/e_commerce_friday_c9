import 'package:e_commerce_friday_c9/data/model/api/response/base_response.dart';

import 'category_dm.dart';
import 'metadata.dart';

class CategoryResponse extends BaseResponse {
  int? results;
  Metadata? metadata;
  List<CategoryDM>? data;

  CategoryResponse({this.results, this.metadata, this.data});

  CategoryResponse.fromJson(dynamic json) {
    results = json["results"];
    message = json["message"];
    metadata =
        json["metadata"] != null ? Metadata.fromJson(json["metadata"]) : null;
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(CategoryDM.fromJson(v));
      });
    }
  }
}
