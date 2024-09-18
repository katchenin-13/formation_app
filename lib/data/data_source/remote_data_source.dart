import 'package:formation_app/data/network/app_api.dart';
import 'package:formation_app/data/request/request.dart';
import 'package:formation_app/data/responses/responses.dart';
import 'package:formation_app/presentation/store_details/storedetails.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHome();
  Future<StoreDetailsResponse> getStoreDetails();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      "",
      "",
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) {
    return _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) {
    return _appServiceClient.register(
      registerRequest.countryMobileCode,
      registerRequest.userName,
      registerRequest.email,
      registerRequest.password,
      registerRequest.mobileNumber,
      registerRequest.profilePicture,
    );}

@override
Future<HomeResponse> getHome() async {
  return await _appServiceClient.getHome();
}


@override
  Future<StoreDetailsResponse> getStoreDetails() async {
    return await _appServiceClient.getStoreDetails();
  }
}
