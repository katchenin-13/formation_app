import 'package:dartz/dartz.dart';
import 'package:formation_app/data/network/failure.dart';
import 'package:formation_app/data/request/request.dart';
import 'package:formation_app/domain/model/model.dart';
import 'package:formation_app/domain/repository/repository.dart';
import 'package:formation_app/domain/usecase/base_usecase.dart';

class RegisterUseCase implements BaseUseCase {
  Repository _repository;

  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    return await _repository.register(RegisterRequest(
      input.countryMobileCode,
      input.userName,
      input.email,
      input.password,
      input.profilePicture,
      input.mobileNumber,
    ));
  }
}

class RegisterInput {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterInput(this.countryMobileCode, this.userName, this.email,
      this.password, this.mobileNumber, this.profilePicture);
}
