import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/overview/domain/entities/task.dart';

abstract class TasksRepositories {
  Future<Either<Failure, List<Tasks>>> getAllTasks();
}