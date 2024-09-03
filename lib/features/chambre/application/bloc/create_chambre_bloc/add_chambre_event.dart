part of 'add_chambre_bloc.dart';

sealed class AddChambreEvent extends Equatable {
  const AddChambreEvent();

  @override
  List<Object> get props => [];
}
class AddChambreButtonPressed extends AddChambreEvent {
  final String name;
  final int entrepriseICE; 
  final int zoneId;
  final double surface;
  final double temperature;

  const AddChambreButtonPressed({required this.name, required this.entrepriseICE , required this.zoneId , required this.surface , required this.temperature});

  @override
  List<Object> get props => [name, entrepriseICE , zoneId , surface , temperature];
}
