import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Tracbalite/domain/entities/tracabilite.dart';
import 'package:flutter/material.dart';

abstract class TracabiliteRepositories{
  Future<Either<Failure, List<Tracabilte>>> getAllTracabilte();
  Future<Either<Failure, List<Tracabilte>>> getTracabiltesByDateRange(DateTimeRange dateRange);
  Future<Either<Failure, List<Tracabilte>>> getTracabiltesByName(String name);
}