import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/shared_preferences.dart';

class GetAllProductsWebServices{
  static late Dio dio;
  GetAllProductsWebServices(){
    BaseOptions baseOptions=BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Accept':'application/json'
        }
    );
    dio=Dio(baseOptions);
  }
  static Future GetData({
    required String url,
  })async{
    dio.options.headers.addAll({
      'Authorization':SharedPref.getData(key:'token'),
      "Accept": "application/json",
    });
    Response response=await dio.get(url);
    return response;
  }

}