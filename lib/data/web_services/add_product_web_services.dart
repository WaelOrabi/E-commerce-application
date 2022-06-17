

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:languages_project/data/models/product_details.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/shared_preferences.dart';


class ProductsWebServices {
 static late Dio dio;

  ProductsWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
        headers: {
          'Accept': 'application/json',
        }
    );
    dio = Dio(baseOptions);
  }
  static Future PostData({
  required String url,
    required dynamic data,
    String ?token,
})async{

    dio.options.headers.addAll({
      'Authorization':SharedPref.getData(key: 'token'),
      "Accept": "application/json",
      "Content-Length": data.files[0].value.length,

    });
    Response response=await dio.post(url,
      data: data,
      

      );
        return response;
}
}
