import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/overview/aplication/datasource/tasks_remote_data_source.dart';
import 'package:devti_agro/features/overview/domain/entities/task.dart';
import 'package:devti_agro/features/overview/domain/repositories/tasks_repositories.dart';

class TasksRepositoryImplement implements TasksRepositories {
  final TasksRemoteDataSource tasksRemoteDataSource;
  final NetworkInfo networkInfo;

  TasksRepositoryImplement(
      {required this.tasksRemoteDataSource, required this.networkInfo});

  // get all tasks future

  @override
  Future<Either<Failure, List<Tasks>>> getAllTasks() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTasksResponse = await tasksRemoteDataSource.getAllTasks();
        return right(remoteTasksResponse);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print("Unexpected error task : $e");
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
