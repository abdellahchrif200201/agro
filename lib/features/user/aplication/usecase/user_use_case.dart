import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/user/infrastructure/ropositories/user_repo.dart';
import '../../domain/entities/user.dart';

/// A use case to retrieve all zones associated with a specific enterprise.
class UserUseCase {
  final UserRepo userRepo;

  UserUseCase({required this.userRepo});

  /// Fetches a list of zones for the given enterprise ID.
  ///
  /// Returns an [Either] containing a [Failure] on error or a list of [Role] objects on success.
  Future<Either<Failure, List<User>>> call() async {
    return await userRepo.getAllUser();
  }
}
