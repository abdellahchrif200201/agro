part of 'add_delete_update_tache_bloc.dart';

abstract class AddDeleteUpdateTacheEvent extends Equatable {
  const AddDeleteUpdateTacheEvent();

  @override
  List<Object> get props => [];
}

class AddTacheEvent extends AddDeleteUpdateTacheEvent {
  final CheckList tache;

  AddTacheEvent({required this.tache});

  @override
  List<Object> get props => [tache];
}

class UpdateTacheEvent extends AddDeleteUpdateTacheEvent {
  final CheckList tache;

  UpdateTacheEvent({required this.tache});

  @override
  List<Object> get props => [tache];
}

class DeleteTacheEvent extends AddDeleteUpdateTacheEvent {
  final int tacheId;

  DeleteTacheEvent({required this.tacheId});

  @override
  List<Object> get props => [tacheId];
}
