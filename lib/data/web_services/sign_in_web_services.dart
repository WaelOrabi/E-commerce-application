import 'package:dio/dio.dart';
import 'package:languages_project/end_points.dart';

class SignInWebServices {
  static late Dio dio;

  SignInWebServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Accept': 'application/json',
        });
    dio = Dio(baseOptions);
  }

  static Future postData({
    required String url,
    // Map<String,dynamic>query,
    required Map<String, dynamic> data,
  }) async {
    print('data=$data');
    print(dio.options.baseUrl);
    Response response = await dio.post(
      url, data: data,
      //  queryParameters: query,
    );
    print("response=${response.data}");
    return response;
  }
}
