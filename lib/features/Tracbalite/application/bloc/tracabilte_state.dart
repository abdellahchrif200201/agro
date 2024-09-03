part of 'tracabilte_bloc.dart';

sealed class TracabilteState extends Equatable {
  const TracabilteState();
  
  @override
  List<Object> get props => [];
}

final class TracabilteInitial extends TracabilteState {}

class LoadingTracabiliteState extends TracabilteState{}

class LoadedTracabiliteState extends TracabilteState{
  final List<Tracabilte> tracabilte;

  const LoadedTracabiliteState({
    required this.tracabilte
  });

  @override
  List<Object> get props => [tracabilte];
}

class ErrorTracabilteState extends TracabilteState{
  final String message;
  const ErrorTracabilteState({
    required this.message
});
  @override
  List<Object> get props => [message];


}

