import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/auth/register/domain/entities/register.dart';

abstract class RegisterRepo {
  Future<Either<Failure, String>> registerAuth(Register register);
}
