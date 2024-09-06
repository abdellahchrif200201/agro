import 'package:dartz/dartz.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:devti_agro/features/chambre/infrastructure/repositories/chambre_repositories.dart';


import '../../../../core/error/failures.dart';

class UpdateChambreUseCase {
  final ChambresRepository repository;

  UpdateChambreUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Chambre chambre) async {
    return await repository.updateChambre(chambre);
  }
}
