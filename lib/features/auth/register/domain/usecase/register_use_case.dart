import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/auth/register/domain/entities/register.dart';
import 'package:devti_agro/features/auth/register/domain/repositories/register_repo.dart';

class RegisterUseCase {
  final RegisterRepo registerRepo;

  RegisterUseCase({required this.registerRepo});

  Future<Either<Failure, String>> call(Register register) async {
    try {
      return await registerRepo.registerAuth(register);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }
}
