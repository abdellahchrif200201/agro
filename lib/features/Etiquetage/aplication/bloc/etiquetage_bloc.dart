import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/Etiquetage/domain/entities/etiquetage.dart';
import 'package:devti_agro/features/Etiquetage/aplication/useCase/get_all_etiquetage_use_case.dart';
import 'package:devti_agro/features/Etiquetage/aplication/useCase/get_etiquetage_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';

part 'etiquetage_event.dart';
part 'etiquetage_state.dart';

class EtiquetageBloc extends Bloc<EtiquetageEvent, EtiquetageState> {
  final GetAllEtiquetageUseCase getAllEtiquetageUseCase;
  final GetEtiquetageByDateUseCase getEtiquetageByDateUseCase;

  EtiquetageBloc({required this.getAllEtiquetageUseCase , required this.getEtiquetageByDateUseCase}) : super(EtiquetageInitial()) {
    on<GetAllEtiquetageEvent>(_onGetAllEtiquetage);
    on<RefreshEtiquetageEvent>(_onRefreshEtiquetage);
    on<SearchEtiquetageEvent>(_onSearchEtiquetage);
    on<FilterEtiquetageByDateRangeEvent>(_onFilterEtiquetqgeByDateRange);
    on<FilterEtiquetageEvent>(_onFilterEtiquetages);
  }

  // on refresh

  Future<void> _onRefreshEtiquetage(RefreshEtiquetageEvent event, Emitter<EtiquetageState> emit) async {
    emit(LoadingEtiquetageState());
    final failureOrEtiquetage = await getAllEtiquetageUseCase();
    emit(_mapFailureOrEtiquetageToState(failureOrEtiquetage));
  }

  // search by name

  Future<void> _onSearchEtiquetage(SearchEtiquetageEvent event, Emitter<EtiquetageState> emit) async {
    emit(LoadingEtiquetageState());
    final failureOrEtiquetage = await getAllEtiquetageUseCase();
    final filteredEtiquetage = failureOrEtiquetage.fold((failure) => <Etiquetage>[], (etiquetage) {
      final etiquetageList = etiquetage.cast<Etiquetage>();
      return etiquetageList.where((etiquetage) {
        return etiquetage.name.toLowerCase().contains(event.searchText.toLowerCase());
      }).toList();
    });

    if (filteredEtiquetage.isEmpty && failureOrEtiquetage.isLeft()) {
      final failure = failureOrEtiquetage.fold((l) => l, (_) => null);
      emit(ErrorEtiquetageState(message: _mapFailureToMessage(failure!)));
    } else {
      emit(LoadedEtiquetageState(etiquetage: filteredEtiquetage));
    }
  }

  // get all etiquetage

  Future<void> _onGetAllEtiquetage(
    GetAllEtiquetageEvent event,
    Emitter<EtiquetageState> emit,
  ) async {
    emit(LoadingEtiquetageState());
    final failureOrEtiquetage = await getAllEtiquetageUseCase();
    emit(_mapFailureOrEtiquetageToState(failureOrEtiquetage));
  }

  EtiquetageState _mapFailureOrEtiquetageToState(Either<Failure, List<Etiquetage>> either) {
    return either.fold(
      (failure) => ErrorEtiquetageState(message: _mapFailureToMessage(failure)),
      (etiquetage) => LoadedEtiquetageState(etiquetage: etiquetage),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        // Consider logging or handling the unknown failure type
        return SERVER_FAILURE_MESSAGE1; // Fallback message
    }
  }

  // filter

  Future<void> _onFilterEtiquetages(
    FilterEtiquetageEvent event,
    Emitter<EtiquetageState> emit,
  ) async {
    final failureOrETiquetage = await getAllEtiquetageUseCase();

    failureOrETiquetage.fold(
      (failure) => emit(ErrorEtiquetageState(message: _mapFailureToMessage(failure))),
      (etiquetage) {
        List<Etiquetage> filteredList;

        if (event.filterType == 'nom' && event.isAscending != null) {
          // Filter by name and sort based on isAscending
          filteredList = etiquetage.where((item) => item.name.isNotEmpty).toList();
          if (event.isAscending!) {
            filteredList.sort((a, b) => a.name.compareTo(b.name));
          } else {
            filteredList.sort((a, b) => b.name.compareTo(a.name));
          }
        } else if (event.filterType == 'dateDDM') {
          // Filter by non-zero Quantite and sort from min to max
          filteredList = etiquetage.where((item) => item.dateDDM.isNotEmpty).toList()..sort((a, b) => a.dateDDM.compareTo(b.dateDDM));
        } else {
          // Default case: no filtering, return the entire list
          filteredList = etiquetage;
        }

        // Emit the filtered list
        emit(LoadedEtiquetageState(etiquetage: filteredList));
      },
    );
  }


  // filter by date range

  Future<void> _onFilterEtiquetqgeByDateRange(
    FilterEtiquetageByDateRangeEvent event,
    Emitter<EtiquetageState> emit,
  ) async {
    emit(LoadingEtiquetageState());

    final failureOrEtiquetqge = await getEtiquetageByDateUseCase(event.dateRange);
    emit(_mapFailureOrEtiquetageToState(failureOrEtiquetqge));
  }
}
