import 'package:dartz/dartz.dart';
import 'package:formation_app/data/network/failure.dart';
import 'package:formation_app/domain/model/model.dart';
import 'package:formation_app/domain/repository/repository.dart';
import 'package:formation_app/domain/usecase/base_usecase.dart';

class HomeUseCase extends BaseUseCase<void,HomeObject>{

  final Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async{
    return await _repository.getHome();
  }
}