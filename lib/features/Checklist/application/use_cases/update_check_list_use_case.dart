import 'package:dartz/dartz.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:devti_agro/features/Checklist/infrastructure/repositories/check_list_repositories.dart';

import '../../../../core/error/failures.dart';


class UpdateTacheUsecase {
  final CheckListRepositories repository;

  UpdateTacheUsecase({
    required this.repository
  });

  Future<Either<Failure, Unit>> call(CheckList checklist) async {
    return await repository.updateTache(checklist);
  }
}
