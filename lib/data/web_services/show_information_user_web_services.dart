import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/shared_preferences.dart';

class ShowInformationUserWebServices{
  static late Dio dio;
  ShowInformationUserWebServices(){
    BaseOptions baseOptions=BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      headers: {
        'Accept':'application/json',
        'Authorization':SharedPref.getData(key: 'token'),
      }
    );
    dio=Dio(baseOptions);
  }
  static Future showInformationUser({required String url})async{
Response response=await dio.get(url);
return response;
  }
}