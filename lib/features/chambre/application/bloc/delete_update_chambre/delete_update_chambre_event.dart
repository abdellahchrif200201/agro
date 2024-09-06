part of 'delete_update_chambre_bloc.dart';

abstract class DeleteUpdateChambreEvent extends Equatable {
  const DeleteUpdateChambreEvent();

  @override
  List<Object> get props => [];
}



class UpdateChambreEvent extends DeleteUpdateChambreEvent {
  final Chambre chambre;

  UpdateChambreEvent({required this.chambre});

  @override
  List<Object> get props => [chambre];
}

class DeleteChambreEvent extends DeleteUpdateChambreEvent {
  final int chambreId;

  DeleteChambreEvent({required this.chambreId});

  @override
  List<Object> get props => [chambreId];
}