import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';

class SearchCategoryWebServices {
  static late Dio dio;
  SearchCategoryWebServices(){
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
    required dynamic name_category,
   required String token,
})async{
    dio.options.headers.addAll({
      'Authorization':token,
      "Accept": "application/json",
      "name":name_category,
    });
    Response response=await dio.get(url,
    );
      return response;
  }
}