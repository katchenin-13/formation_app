import 'package:formation_app/data/network/app_api.dart';
import 'package:formation_app/data/request/request.dart';
import 'package:formation_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer( this._appServiceClient);
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
    return _appServiceClient.forgotPassword(email);}
}