class AddCategory {
  String ? name;
  String ? description;
  String ? updatedAt;
  String ? createdAt;
  int ? id;

  AddCategory(
      {this.name,
        this.description,
        this.updatedAt,
        this.createdAt,
        this.id,});
  AddCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}