import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/features/zone/aplication/usecase/zone_use_case.dart';
import 'package:equatable/equatable.dart';

import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/zone/domain/entities/zone.dart';

// Define events
part 'zone_event.dart';

// Define states
part 'zone_state.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  final GetZonesByEntrepriseUseCase zoneUseCase;

  ZoneBloc({required this.zoneUseCase}) : super(ZoneInitial()) {
    on<GetAllZoneEvent>(_onGetAllZones);
  }

  Future<void> _onGetAllZones(
    GetAllZoneEvent event,
    Emitter<ZoneState> emit,
  ) async {
    emit(LoadingZoneState());

    final failureOrZones = await zoneUseCase.call(event.idEntreprise);
    emit(_mapFailureOrZonesToState(failureOrZones));
  }

  ZoneState _mapFailureOrZonesToState(
    Either<Failure, List<Zone>> either,
  ) {
    return either.fold(
      (failure) => ErrorZoneState(message: _mapFailureToMessage(failure)),
      (zones) => LoadedZoneState(zone: zones),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    } else if (failure is OfflineFailure) {
      return 'Offline Failure';
    } else {
      print('Unknown Failure: ${failure.runtimeType}');
      return 'Unexpected Error';
    }
  }
}
