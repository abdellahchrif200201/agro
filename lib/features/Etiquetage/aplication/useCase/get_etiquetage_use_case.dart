import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Etiquetage/domain/entities/etiquetage.dart';
import 'package:devti_agro/features/Etiquetage/infrastructure/repositories/etiquetage_repositories.dart';
import 'package:flutter/material.dart';

class GetEtiquetageByDateUseCase {
  final EtiquetageRepositories repositories;
  GetEtiquetageByDateUseCase({required this.repositories});

  Future<Either<Failure, List<Etiquetage>>> call(DateTimeRange dateRange) async {
    return await repositories.getEtiquetagesByDateRange(dateRange);
  }
}
