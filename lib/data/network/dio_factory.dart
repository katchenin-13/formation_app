import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:formation_app/app/app_prefs.dart';
import 'package:formation_app/app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "Accept";
const String AUTHORIZATION = "Authorization"; // Capitalize 'Authorization'
const String DEFAULT_LANGUAGE = "Language"; // Capitalize 'Language'

class DioFactory {
  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Duration _timeOut = const Duration(seconds: 60); // 60 seconds

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: await _appPreferences.getAppLanguage(),
    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers: headers,
    );
    if(kReleaseMode){
      print("release mode on logs");
    }
    else{
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true
      ));
    }

    return dio;
  }
}
