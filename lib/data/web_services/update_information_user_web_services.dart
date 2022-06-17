import 'dart:io';

import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/shared_preferences.dart';

class UpdateInformationUserWebServices{
 static late Dio dio;
  UpdateInformationUserWebServices(){
    BaseOptions baseOptions=BaseOptions(
      baseUrl: baseUrl,
    headers: {
   'Accept':'application/json'
    }
    );
    dio=Dio(baseOptions);
  }
  static Future PostData({
    required String url,
   required dynamic data,
})async{
    dio.options.headers.addAll({
      'Authorization':SharedPref.getData(key: 'token'),
      "Accept": "application/json",
      "Content-Length": data.files[0].value.length,

    });
    Response response=await dio.put(url,
      data:data
    );
    return response;
  }
}