import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/auth/login/domain/entities/login.dart';

abstract class LoginRepo{
  Future<Either<Failure , Unit>> loginAuth(Login login);
}