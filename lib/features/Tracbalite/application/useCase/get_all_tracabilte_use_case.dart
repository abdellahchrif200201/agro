import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Tracbalite/domain/entities/tracabilite.dart';
import 'package:devti_agro/features/Tracbalite/infrastructure/repositories/tracabilite_repositories.dart';

class GetAllTracabilteUseCase{
  final TracabiliteRepositories tracabiliteRepositories;
  GetAllTracabilteUseCase({
    required this.tracabiliteRepositories
  });

  Future<Either<Failure , List<Tracabilte>>> call() async{
    return await tracabiliteRepositories.getAllTracabilte();
  }

}