import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/permission/infrastructure/ropositories/permission_repo.dart';
import '../../domain/entities/permission.dart';

/// A use case to retrieve all zones associated with a specific enterprise.
class PermissionUseCase {
  final PermissionRepo permissionRepo;

  PermissionUseCase({required this.permissionRepo});

  /// Fetches a list of zones for the given enterprise ID.
  ///
  /// Returns an [Either] containing a [Failure] on error or a list of [Role] objects on success.
  Future<Either<Failure, List<Permission>>> call() async {
    return await permissionRepo.getAllPermission();
  }
}
