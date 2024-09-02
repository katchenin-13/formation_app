import 'package:dartz/dartz.dart';
import 'package:formation_app/app/functions.dart';
import 'package:formation_app/data/network/failure.dart';
import 'package:formation_app/data/request/request.dart';
import 'package:formation_app/domain/model/model.dart';
import 'package:formation_app/domain/repository/repository.dart';
import 'package:formation_app/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
  Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
    DeviceInfo _deviceInfo = await getDeviceDetails();
   return await _repository.login(LoginRequest(input.email, input.password, _deviceInfo.identifier, _deviceInfo.name));

 
  }}
 
class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);

}