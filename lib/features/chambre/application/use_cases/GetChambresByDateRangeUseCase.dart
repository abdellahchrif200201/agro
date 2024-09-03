
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:devti_agro/features/chambre/infrastructure/repositories/chambre_repositories.dart';
import 'package:flutter/material.dart';

class GetChambresByDateRangeUseCase {
  final ChambresRepository repository;

  GetChambresByDateRangeUseCase(this.repository);

  Future<Either<Failure, List<Chambre>>> call(DateTimeRange dateRange) async {
    return await repository.getChambresByDateRange(dateRange);
  }
}

