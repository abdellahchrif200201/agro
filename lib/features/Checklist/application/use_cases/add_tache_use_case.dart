import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:devti_agro/features/Checklist/infrastructure/repositories/check_list_repositories.dart';

class AddTacheUseCase{
   final CheckListRepositories repository;

  AddTacheUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(CheckList tache) async {
    return await repository.addTache(tache);
  }
}