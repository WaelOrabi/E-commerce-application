class ShowInformationUserModel {
  int ? id;
  String ? name;
  String ? email;
  String ? profImgUrl;
  dynamic  facebookUrl;
  dynamic  whatsappUrl;
  String ? phoneNumber;
  String ? createdAt;
  String ? updatedAt;

  ShowInformationUserModel(
      {this.id,
        this.name,
        this.email,
        this.profImgUrl,
        this.facebookUrl,
        this.whatsappUrl,
        this.phoneNumber,
        this.createdAt,
        this.updatedAt});

  ShowInformationUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profImgUrl = json['prof_img_url'];
    facebookUrl = json['facebook_url'];
    whatsappUrl = json['whatsapp_url'];
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}