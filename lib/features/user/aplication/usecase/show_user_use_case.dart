import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
// import 'package:devti_agro/features/user/aplication/model/user_model.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:devti_agro/features/user/infrastructure/ropositories/user_repo.dart';

class ShowUserUseCase {
  final UserRepo userRepo;

  ShowUserUseCase({required this.userRepo});

  Future<Either<Failure, User>> call(int userId) async {
    return await userRepo.showUser(userId);
  }
}
