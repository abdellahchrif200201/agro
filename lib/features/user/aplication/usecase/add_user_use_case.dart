import 'package:dartz/dartz.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:devti_agro/features/user/infrastructure/ropositories/user_repo.dart';

import '../../../../core/error/failures.dart';


class AddUserUseCase {
  final UserRepo userRepo;

  AddUserUseCase({
    required this.userRepo
  });

  Future<Either<Failure, Unit>> call(User user) async {
    return await userRepo.addUser(user);
  }
}
