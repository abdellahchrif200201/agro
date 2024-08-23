import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:devti_agro/features/chambre/domain/repositories/chambre_repositories.dart';

class GetAllChambresUseCase{
  final ChambresRepository chambresRepository;

  GetAllChambresUseCase(this.chambresRepository);

  Future<Either<Failure , List<Chambre>>> call() async {
    return await chambresRepository.getAllChambres();
  }
}