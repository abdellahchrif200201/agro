part of 'add_chambre_bloc.dart';

sealed class AddChambreState extends Equatable {
  const AddChambreState();
  
  @override
  List<Object> get props => [];
}

final class AddChambreInitial extends AddChambreState {}


class AddChambreLoading extends AddChambreState {}

class AddChambreSuccess extends AddChambreState {}

class AddChambreFailure extends AddChambreState {
  final String message;

  const AddChambreFailure({required this.message});

  @override
  List<Object> get props => [message];
}
