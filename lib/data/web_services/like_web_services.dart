import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/shared_preferences.dart';
class LikeWebServices{
  static late Dio dio;
  LikeWebServices(){
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
  static Future GetData({
  required String url,
    required int id_product,
})async{
    Response response=await dio.get(url+'/$id_product');
    return response;
  }
  static Future DeleteData({
  required String url,
    required int id_product,
})async{
    Response response=await dio.delete(url+'/$id_product');
    return response;
  }
}