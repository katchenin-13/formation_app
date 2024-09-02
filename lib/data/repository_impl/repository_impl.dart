import 'package:dartz/dartz.dart';
import 'package:formation_app/data/data_source/remote_data_source.dart';
import 'package:formation_app/data/mapper/mapper.dart';
import 'package:formation_app/data/network/error_handler.dart';
import 'package:formation_app/data/network/failure.dart';
import 'package:formation_app/data/network/network_info.dart';
import 'package:formation_app/data/request/request.dart';
import 'package:formation_app/domain/model/model.dart';
import 'package:formation_app/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfoImpl _networkInfoImpl;
  RepositoryImpl(this._remoteDataSource, this._networkInfoImpl);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfoImpl.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // return data(success)
          // return right
          return Right(response.toDomain());
        } else {
          //return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
      //its safe to call the api
    } else {
      ///return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfoImpl.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // return data(success)
          // return right
          return Right(response.toDomain());
        } else {
          //return biz logic error
          // return left
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfoImpl.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // return data(success)
          // return right
          return Right(response.toDomain());
        } else {
          //return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
      //its safe to call the api
    } else {
      ///return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
