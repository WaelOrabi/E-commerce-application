class UpdateInformationUserModel {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic profImgUrl;
  dynamic facebookUrl;
  dynamic whatsappUrl;
  dynamic phoneNumber;
  dynamic createdAt;
  dynamic updatedAt;

  UpdateInformationUserModel.fromJson(Map<String, dynamic> json) {
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