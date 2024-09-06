import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/user/infrastructure/ropositories/user_repo.dart';

class DeleteUserUseCase{
  final UserRepo userRepo;
  DeleteUserUseCase({required this.userRepo});

  Future<Either<Failure, Unit>> call(int userId) async {
    return await userRepo.deleteUser(userId);
  }
}