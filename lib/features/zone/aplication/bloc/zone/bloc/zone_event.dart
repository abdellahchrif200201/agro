part of 'zone_bloc.dart';

sealed class ZoneEvent extends Equatable {
  const ZoneEvent();

  @override
  List<Object> get props => [];
}

class GetAllZoneEvent extends ZoneEvent {
  final int idEntreprise;

  const GetAllZoneEvent({required this.idEntreprise});

  @override
  List<Object> get props => [idEntreprise];
}
