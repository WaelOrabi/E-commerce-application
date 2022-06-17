class SearchCategoryModel {
  int? id;
  String? name;
  String? imgUrl;
  String? description;
  String? createdAt;
  String? updatedAt;

  SearchCategoryModel(
      {this.id,
      this.name,
      this.imgUrl,
      this.description,
      this.createdAt,
      this.updatedAt});

  SearchCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imgUrl = json['img_url'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
