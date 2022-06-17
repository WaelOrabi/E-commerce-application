class SignIn{
String ? token_type;
String ? access_token;
UserData ? dataUser;
String  ?message;
SignIn.fromJson(Map<String,dynamic> json){
  token_type=json['token_type']??null;
  access_token=json['access_token']??null;
  dataUser=json['user']!=null?UserData.fromJson(json['user']):null;
  message=json['message'] ??null;
}
}
class UserData{
  int ? id;
  String ? name;
  String ? email;
  String ? prof_img_url;
  String ? facebook_url;
  String ? whatsapp_url;
  String ? phone_number;
  String ? created_at;
  String ? updated_at;
  UserData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    prof_img_url=json['prof_img_url'];
    facebook_url=json['facebook_url'];
    whatsapp_url=json['whatsapp_url'];
    phone_number=json['phone_number'];
    created_at=json['created_at'];
    updated_at=json['updated_at'];

  }
}