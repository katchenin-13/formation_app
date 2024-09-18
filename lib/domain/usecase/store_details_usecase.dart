import 'package:dartz/dartz.dart';
import 'package:formation_app/data/network/failure.dart';
import 'package:formation_app/domain/model/model.dart';
import 'package:formation_app/domain/repository/repository.dart';
import 'package:formation_app/domain/usecase/base_usecase.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {

  final Repository _repository;

  StoreDetailsUseCase(this._repository);
  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {

    return _repository.getStoreDetails();
  
  }
  
}