import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:devti_agro/features/chambre/infrastructure/repositories/chambre_repositories.dart';

import '../../../../../core/error/exeptions.dart';

class AddChambreUseCase {
  final ChambresRepository chambresRepository;

  AddChambreUseCase({required this.chambresRepository});

  Future<Either<Failure, Unit>> call(Chambre chambre) async {
    try {
      return await chambresRepository.addChambre(chambre);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }
}
