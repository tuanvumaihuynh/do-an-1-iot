import 'package:dio/dio.dart';

class APIService {
  static Future<dynamic> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final dio = Dio();
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (error) {}
    return null;
  }
}
