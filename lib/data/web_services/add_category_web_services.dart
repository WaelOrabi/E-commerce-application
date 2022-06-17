import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';

class AddCategoryWebServices{
  static late Dio dio;
  AddCategoryWebServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Accept': 'application/json',
        }
    );
    dio = Dio(baseOptions);
  }
  static Future PostData({required String token,required String url,required dynamic data})async{
    dio.options.headers.addAll({
      'Authorization':token,
      "Accept": "application/json",
      "Content-Length": data.files[0].value.length,
    });
    print("tttttttttoooooooooooookkkkkkkkkkkkkeeeeeeeeenn=${token}");
   Response response= await dio.post(url,
      data: data,


    );
      return response;
  }
}