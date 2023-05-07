import 'package:dartz/dartz.dart';
import 'package:flutter_adv/domain/model/models.dart';

import '../../data/network/Failure.dart';
import '../../data/network/requests.dart';

abstract class Repository{
Future <Either<Failure,Authentication>> login(LoginRequest loginRequest);
}
