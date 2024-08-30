part of 'zone_bloc.dart';

sealed class ZoneState extends Equatable {
  const ZoneState();
  
  @override
  List<Object> get props => [];
}

final class ZoneInitial extends ZoneState {}

class LoadingZoneState extends ZoneState {}

class LoadedZoneState extends ZoneState {
  final List<Zone> zone;

  const LoadedZoneState({required this.zone});

  @override
  List<Object> get props => [zone];
}

class ErrorZoneState extends ZoneState {
  final String message;

  const ErrorZoneState({required this.message});

  @override
  List<Object> get props => [message];
}
