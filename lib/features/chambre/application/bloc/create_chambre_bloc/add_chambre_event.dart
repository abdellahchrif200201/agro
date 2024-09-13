part of 'add_chambre_bloc.dart';

sealed class AddChambreEvent extends Equatable {
  const AddChambreEvent();

  @override
  List<Object> get props => [];
}
class AddChambreButtonPressed extends AddChambreEvent {
  final Chambre chambre;

  const AddChambreButtonPressed({required this.chambre});

  @override
  List<Object> get props => [chambre];
}
