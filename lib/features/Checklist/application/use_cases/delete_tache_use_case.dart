import 'package:devti_agro/features/Checklist/infrastructure/repositories/check_list_repositories.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class DeleteTacheUseCase {
  final CheckListRepositories repository;

  DeleteTacheUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteTache(id);
  }
}
