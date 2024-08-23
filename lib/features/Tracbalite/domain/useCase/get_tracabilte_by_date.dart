import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Tracbalite/domain/entities/tracabilite.dart';
import 'package:devti_agro/features/Tracbalite/domain/repositories/tracabilite_repositories.dart';
import 'package:flutter/material.dart';

class GetTracabiliteByDateUseCase {
  final TracabiliteRepositories repositories;
  GetTracabiliteByDateUseCase({required this.repositories});

  Future<Either<Failure, List<Tracabilte>>> call(DateTimeRange dateRange) async {
    return await repositories.getTracabiltesByDateRange(dateRange);
  }
}