import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/zone/infrastructure/ropositories/zone_repo.dart';
import '../../domain/entities/zone.dart';

/// A use case to retrieve all zones associated with a specific enterprise.
class GetZonesByEntrepriseUseCase {
  final ZoneRepo zoneRepo;

  GetZonesByEntrepriseUseCase({required this.zoneRepo});

  /// Fetches a list of zones for the given enterprise ID.
  ///
  /// Returns an [Either] containing a [Failure] on error or a list of [Zone] objects on success.
  Future<Either<Failure, List<Zone>>> call(int idEntreprise) async {
    return await zoneRepo.getAllZoneByEntreprise(idEntreprise);
  }
}
