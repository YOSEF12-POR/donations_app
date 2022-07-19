import 'package:dio/dio.dart';
import 'package:donations_app/shared/network/end_points.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        // baseUrl: 'https://student.valuxapps.com/api/',
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        // headers: {
        //   'Content-Type': 'application/json',
        //   'lang': 'en',

        // }
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'lang': lang,
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'ar',
    String? token,
    int? iduser,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer $token',
      'lang': lang,
      
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'ar',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'lang': lang,
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
