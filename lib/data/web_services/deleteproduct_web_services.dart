import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/shared_preferences.dart';

class DeleteProductWebServices{
  static late Dio dio;
  DeleteProductWebServices(){
    BaseOptions baseOptions=BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Accept':'application/json',
        }
    );
    dio=Dio(baseOptions);
  }
  static Future DeleteProduct({
    required String url,
  })async{
    dio.options.headers.addAll({
      'Authorization':SharedPref.getData(key: 'token'),
      'Accept':'application/json',
    });
    Response response=await dio.delete(url);
    return response;
  }
}