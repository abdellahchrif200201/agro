import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:flutter/src/material/date.dart';

abstract class ChambresRepository{
  Future<Either<Failure , List<Chambre>>> getAllChambres();
  Future<Either<Failure , List<Chambre>>> getChambresByDateRange(DateTimeRange dateRange);
  Future<Either<Failure , List<Chambre>>> getChambresByName(String name);
  Future<Either<Failure, Unit>> addChambre(Chambre chambre);
}

