import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';

class SearchProductsWebServices {
  static late Dio dio;
  SearchProductsWebServices(){
    BaseOptions baseOptions=BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Accept':'application/json',
        }
    );
    dio=Dio(baseOptions);
  }
  static Future GetData({
    required String url,
    required dynamic name_Products,
    required String token,
    required Map<String,dynamic>data,
  })async{
    dio.options.headers.addAll({
      'Authorization':token,
      "Accept": "application/json",
      "name":name_Products,
    });
    Response response=await dio.post(url,
      data: data,
    );
    return response;
  }
}