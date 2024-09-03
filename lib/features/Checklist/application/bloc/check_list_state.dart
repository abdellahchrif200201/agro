part of 'check_list_bloc.dart';

abstract class CheckListState extends Equatable {
  const CheckListState();

  @override
  List<Object> get props => [];
}

class CheckListInitial extends CheckListState {}

class LoadingCheckListState extends CheckListState {}

class LoadedCheckListState extends CheckListState {
  final List<CheckList> checkList;

  const LoadedCheckListState({required this.checkList});

  @override
  List<Object> get props => [checkList];
}

class ErrorCheckListState extends CheckListState {
  final String message;

  const ErrorCheckListState({required this.message});

  @override
  List<Object> get props => [message];
}
