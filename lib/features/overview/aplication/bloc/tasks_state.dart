part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();
  
  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

class LoadingTasksState extends TasksState{}

class LoadedTasksState extends TasksState{
  final List<Tasks> tasks;
  LoadedTasksState({
    required this.tasks
  });
  
  @override
  List<Object> get props => [tasks];
}

class ErrorTasksState extends TasksState{
  final String message;
  ErrorTasksState({
    required this.message
  });

  @override
  List<Object> get props => [message];
}