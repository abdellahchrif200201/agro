import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Etiquetage/domain/entities/etiquetage.dart';
import 'package:devti_agro/features/Etiquetage/infrastructure/repositories/etiquetage_repositories.dart';

class GetAllEtiquetageUseCase{
  final EtiquetageRepositories etiquetageRepositories;
  GetAllEtiquetageUseCase({
    required this.etiquetageRepositories
});

  Future<Either<Failure , List<Etiquetage>>> call() async{
    return await etiquetageRepositories.getAllEtiquetage();
  }
}