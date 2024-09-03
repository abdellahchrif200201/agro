import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/nutrition/domain/entities/nutrition.dart';
import 'package:devti_agro/features/nutrition/infrastructure/repositories/nutiration_repositories.dart';

class GetAllNutirationUseCase{
  final NutirationRepositories nutirationRepositories;
  GetAllNutirationUseCase({
    required this.nutirationRepositories
  });


  Future<Either<Failure , List<Nutrition>>> call() async{
    return await nutirationRepositories.getAllNutrition();
  }

}