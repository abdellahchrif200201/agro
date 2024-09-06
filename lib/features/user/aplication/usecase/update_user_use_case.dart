import 'package:dartz/dartz.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:devti_agro/features/user/infrastructure/ropositories/user_repo.dart';

import '../../../../core/error/failures.dart';


class UpdateUserUsecase {
  final UserRepo userRepo;

  UpdateUserUsecase({
    required this.userRepo
  });

  Future<Either<Failure, Unit>> call(User user) async {
    return await userRepo.updateUser(user);
  }
}
