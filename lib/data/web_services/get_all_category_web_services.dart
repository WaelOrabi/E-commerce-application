import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/shared_preferences.dart';

class GetAllCategoryWebServices{
   static late Dio dio;
   GetAllCategoryWebServices(){
     BaseOptions baseOptions=BaseOptions(
       baseUrl: baseUrl,
     //  receiveTimeout: 80*1000,
     //  responseType: ResponseType.json,
       receiveDataWhenStatusError: true,
       headers: {
         'Accept': 'application/json',
       }
     );
     dio=Dio(baseOptions);
}
static Future getAllCategories({required String url})async{
  dio.options.headers.addAll({
    'Authorization':SharedPref.getData(key: 'token'),
    "Accept": "application/json",

  });
    Response response= await dio.get(url);
    print(response.data);
       return response;


}
}