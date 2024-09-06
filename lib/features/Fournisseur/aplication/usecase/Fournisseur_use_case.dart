import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Fournisseur/infrastructure/ropositories/fournisseur_repo.dart';
import '../../domain/entities/Fournisseur.dart';

/// A use case to retrieve all zones associated with a specific enterprise.
class FournisseurUseCase {
  final FournisseurRepo fournisseurRepo;

  FournisseurUseCase({required this.fournisseurRepo});

  /// Fetches a list of zones for the given enterprise ID.
  ///
  /// Returns an [Either] containing a [Failure] on error or a list of [Role] objects on success.
  Future<Either<Failure, List<Fournisseur>>> call() async {
    return await fournisseurRepo.getAllFournisseur();
  }
}
