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

@POST("/customers/register")
  Future<AuthenticationResponse>register(
    @Field("country_mobile_code") String countryMobileCode,
    @Field("user_name") String userName,
    @Field("email") String email,
    @Field("password") String password,
    @Field("mobile_number") String mobileNumber,
    @Field("profile_picture") String profilePicture,
    
  );   

  @GET("/home")  
  Future<HomeResponse>getHome();

  @GET("/storeDetails/1")
  Future<StoreDetailsResponse>getStoreDetails();

}

