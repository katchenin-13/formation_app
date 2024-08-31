import 'package:formation_app/app/constant.dart';
import 'package:formation_app/data/responses/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient{

  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customer/login")
  Future<AuthenticationResponse>login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );

  @POST("/customer/forgotPassword")
  Future<ForgotPasswordResponse>forgotPassword(
    @Field("email") String email,
  );

  // @POST("/customer/register")
  // Future<AuthenticationResponse>register(
  //   @Field("fName") String fName,
  //   @Field("lName") String lName,
  //   @Field("email") String email,
  //   @Field("password") String password,
  //   @Field("imei") String imei,
  //   @Field("deviceType") String deviceType,
  // );

}