class SignUp{
  String ? token_type;
  String ? access_token;
  UserData ? dataUser;
  String  ?prof_img_url;
  SignUp.fromJson(Map<String,dynamic> json){
    token_type=json['token_type']??null;
    access_token=json['access_token']??null;
    prof_img_url=json['prof_img_url']??null;
    dataUser=json['user']!=null?UserData.fromJson(json['user']):null;
  }
}
class UserData{
  int ? id;
  String ? name;
  String ? email;
  String ? phone_number;
  String ? created_at;
  String ? updated_at;
  UserData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    phone_number=json['phone_number'];
    created_at=json['created_at'];
    updated_at=json['updated_at'];

  }
}