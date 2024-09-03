import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/overview/domain/entities/task.dart';
import 'package:devti_agro/features/overview/aplication/use_case/get_all_tasks.dart';
import 'package:equatable/equatable.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetAllTasksUseCase getAllTasks;

  TasksBloc({required this.getAllTasks}) : super(TasksInitial()) {
    on<GetAllTasksEvent>(_onGetAllTasks);
  }

  // Future to get all tasks
  Future<void> _onGetAllTasks(
    GetAllTasksEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(LoadingTasksState());
    final failureOrTasks = await getAllTasks();
    emit(_mapFailureOrTasksToState(failureOrTasks as Either<Failure, List<Tasks>>));
  }

  // Map failure or tasks to state
  TasksState _mapFailureOrTasksToState(Either<Failure, List<Tasks>> either) {
    return either.fold(
      (failure) => ErrorTasksState(message: _mapFailureToMessage(failure)),
      (tasks) => LoadedTasksState(tasks: tasks),
    );
  }

  // Map failure to message
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        print('Unknown Failure: ${failure.runtimeType}');
        return SERVER_FAILURE_MESSAGE1;
    }
  }
}
