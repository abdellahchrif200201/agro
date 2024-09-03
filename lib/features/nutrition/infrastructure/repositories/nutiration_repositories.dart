import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/nutrition/domain/entities/nutrition.dart';

abstract class NutirationRepositories{
  Future<Either<Failure, List<Nutrition>>> getAllNutrition();
  // Future<Either<Failure, List<Nutrition>>> getNutritionsByDateRange(DateTimeRange dateRange);
  // Future<Either<Failure, List<Nutrition>>> getNutritionsByName(String name);
}