class CategoryDM {
  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? category;

  CategoryDM(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.category});

  CategoryDM.fromJson(dynamic json) {
    id = json["_id"];
    name = json["name"];
    slug = json["slug"];
    image = json["image"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    category = json["category"];
  }
// CategoryEntity toEntity(){
//   return CategoryEntity(id!, name!, image!);
// }
}
// class CategoryEntity{
//    String id;
//    String name;
//    String image;
//
//    CategoryEntity(this.id, this.name, this.image);
// }
