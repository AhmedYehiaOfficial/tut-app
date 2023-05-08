import 'package:dartz/dartz.dart';
import 'package:flutter_adv/data/mapper/mapper.dart';

import 'package:flutter_adv/data/network/Failure.dart';
import 'package:flutter_adv/data/network/error_handler.dart';

import 'package:flutter_adv/data/network/requests.dart';

import 'package:flutter_adv/domain/model/models.dart';

import '../../app/constants.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its connected to the network internet so its safe to call api
      try {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //return either right
          // return data
          return Right(response.toDomain());
        } else {
          //failure -- business error
          //return either left
          return left(
              Failure(ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return internet connection error
      //return either left
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
