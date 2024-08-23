import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Etiquetage/domain/entities/etiquetage.dart';
import 'package:flutter/material.dart';

abstract class EtiquetageRepositories{
  Future<Either<Failure , List<Etiquetage>>> getAllEtiquetage();
  Future<Either<Failure, List<Etiquetage>>> getEtiquetagesByDateRange(DateTimeRange dateRange);
  Future<Either<Failure , List<Etiquetage>>> getEtiquetageByName(String name);
}