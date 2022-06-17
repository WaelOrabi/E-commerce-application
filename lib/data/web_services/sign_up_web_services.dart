import 'package:dio/dio.dart';
import 'package:languages_project/data/models/sign_up.dart';
import 'package:languages_project/end_points.dart';


class SignUpWepServices {
  static late Dio dio;

  SignUpWepServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Accept': 'application/json',
        }

    );
    dio = Dio(baseOptions);
  }
  static  Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data}) async {
    print("data=${data}");
  Response response= await dio.post(
    url,
    data: data,
  );
    print ("response=${response.data}");
  return response;

  }

}
