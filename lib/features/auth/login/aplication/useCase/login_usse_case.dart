import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/auth/login/domain/entities/login.dart';
import 'package:devti_agro/features/auth/login/infrastructure/repositories/login_repo.dart';

import '../../../../../core/error/exeptions.dart';

class LoginUseCase {
  final LoginRepo loginRepo;

  LoginUseCase({required this.loginRepo});

 Future<Either<Failure, Unit>> call(Login login) async {
    try {
      return await loginRepo.loginAuth(login);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }
}
