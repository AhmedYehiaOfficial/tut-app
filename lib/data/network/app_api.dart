import 'package:dio/dio.dart';
import 'package:flutter_adv/app/constants.dart';
import 'package:retrofit/http.dart';

import '../responces/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl) //base url
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
}
