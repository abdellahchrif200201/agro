import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:devti_agro/features/Checklist/infrastructure/repositories/check_list_repositories.dart';
import 'package:flutter/material.dart';

class GetCheckListByDateUseCase{
  final CheckListRepositories repositories;
  GetCheckListByDateUseCase({
    required this.repositories
  });

  Future<Either<Failure, List<CheckList>>> call(DateTimeRange dateRange) async {
    return await repositories.getCheckListsByDateRange(dateRange);
  }

}