import 'package:dio/dio.dart';
import 'package:salesrep/shared/network/remote/end_points.dart';

class DioHelper {
  static Dio? dio;
  static initAppDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? authorization,
  }) async {
    if (authorization != null) {
      dio!.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': authorization,
      };
    } else {
      dio!.options.headers = {
        'Content-Type': 'application/json',
      };
    }
    return await dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? authorization,
  }) async {
    if (authorization != null) {
      dio!.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': authorization,
      };
    } else {
      dio!.options.headers = {
        'Content-Type': 'application/json',
      };
    }
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}
