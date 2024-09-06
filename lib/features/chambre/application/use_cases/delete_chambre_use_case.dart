import 'package:devti_agro/features/chambre/infrastructure/repositories/chambre_repositories.dart';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class DeleteChambreUseCase {
  final ChambresRepository repository;

  DeleteChambreUseCase({
    required this.repository
  });

  Future<Either<Failure, Unit>> call(int idChambre) async {
    return await repository.deleteChambre(idChambre);
  }
}
