import 'package:flutter_adv/data/network/app_api.dart';
import 'package:flutter_adv/data/network/requests.dart';
import 'package:flutter_adv/data/responces/responses.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
  return await _appServiceClient.login(loginRequest.email, loginRequest.password);
  }
}
