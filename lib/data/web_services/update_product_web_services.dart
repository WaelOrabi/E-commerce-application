

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:languages_project/data/models/product_details.dart';
import 'package:languages_project/end_points.dart';
import 'package:languages_project/shared_preferences.dart';


class UpdateProductWebServices {
  static late Dio dio;

  UpdateProductWebServices() {
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
  })async{
    print("daaaaaata=${data}");
    print('${SharedPref.getData(key: 'token')}');

    dio.options.headers.addAll({
      'Authorization':SharedPref.getData(key: 'token'),
      "Accept": "application/json",
      "Content-Length": data.files.isEmpty?null:data.files[0].value.length,

    }..removeWhere((key, value) => value == null));
    Response response=await dio.post(url,
      data: data).then((value) {
        print(value);
        return value;
    }).catchError((error){
      print(error);
    });
  }
}
