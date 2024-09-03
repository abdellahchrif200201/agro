import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/overview/domain/entities/task.dart';
import 'package:devti_agro/features/overview/infrastructure/repositories/tasks_repositories.dart';

class GetAllTasksUseCase{
  final TasksRepositories tasksRepositories;
  GetAllTasksUseCase({
    required this.tasksRepositories
  });

  Future<Either<Failure , List<Tasks>>> call() async{
    return await tasksRepositories.getAllTasks();
  }
}