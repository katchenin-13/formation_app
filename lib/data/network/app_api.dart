import 'package:formation_app/app/constant.dart';
import 'package:formation_app/data/responses/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class ApiServiceClient{

  factory ApiServiceClient(Dio dio, {String baseUrl}) = _ApiServiceClient;

  @POST("/customer/login")
  Future<AuthenticationResponse>login();

}