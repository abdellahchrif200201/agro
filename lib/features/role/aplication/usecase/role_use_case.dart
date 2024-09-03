import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/role/infrastructure/ropositories/role_repo.dart';
import '../../domain/entities/role.dart';

/// A use case to retrieve all zones associated with a specific enterprise.
class RoleUseCase {
  final RoleRepo roleRepo;

  RoleUseCase({required this.roleRepo});

  /// Fetches a list of zones for the given enterprise ID.
  ///
  /// Returns an [Either] containing a [Failure] on error or a list of [Role] objects on success.
  Future<Either<Failure, List<Role>>> call() async {
    return await roleRepo.getAllRole();
  }
}
