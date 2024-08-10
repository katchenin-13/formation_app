import 'package:dio/dio.dart';
import 'package:formation_app/app/constant.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "Accept";
const String AUTHORIZATION = "Authorization"; // Capitalize 'Authorization'
const String DEFAULT_LANGUAGE = "Language"; // Capitalize 'Language'

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Duration _timeOut = const Duration(seconds: 60); // 60 seconds

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: "en",
    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers: headers,
    );

    return dio;
  }
}
