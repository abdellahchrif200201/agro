import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/Tracbalite/domain/entities/tracabilite.dart';
import 'package:devti_agro/features/Tracbalite/domain/useCase/get_all_tracabilte_use_case.dart';
import 'package:devti_agro/features/Tracbalite/domain/useCase/get_tracabilte_by_date.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tracabilte_event.dart';
part 'tracabilte_state.dart';

class TracabilteBloc extends Bloc<TracabilteEvent, TracabilteState> {
  final GetAllTracabilteUseCase getAllTracabilteUseCase;
  final GetTracabiliteByDateUseCase getTracabiliteByDateUseCase;

  TracabilteBloc({required this.getAllTracabilteUseCase, required this.getTracabiliteByDateUseCase}) : super(TracabilteInitial()) {
    on<GetAllTracabiliteEvent>(_onGetAllTracabilite);
    on<RefreshTracabilteEvent>(_onRefreshTracabilite);
    on<FilterTracabilteByDateRangeEvent>(_onFilterTracabiliteByDateRange);
    on<SearchTracabilteEvent>(_onSearchTracabilte);
    on<FilterTracabilteEvent>(_onFilterTracabiltes);
  }

  // future get all tracabilte

  Future<void> _onGetAllTracabilite(
    GetAllTracabiliteEvent event,
    Emitter<TracabilteState> emit,
  ) async {
    emit(LoadingTracabiliteState());
    final failureOrTracabilite = await getAllTracabilteUseCase();
    emit(_mapFailureOrTracabiliteToState(failureOrTracabilite));
  }

  // on refresh

  Future<void> _onSearchTracabilte(
    SearchTracabilteEvent event,
    Emitter<TracabilteState> emit,
  ) async {
    emit(LoadingTracabiliteState());

    final failureOrTracabilte = await getAllTracabilteUseCase();

    final filteredTracabilte = failureOrTracabilte.fold(
      (failure) => <Tracabilte>[], // Return an empty list on failure
      (tracabilte) {
        final tracabilteList = tracabilte.cast<Tracabilte>();
        return tracabilteList.where((tracabilte) {
          return tracabilte.name.toLowerCase().contains(event.searchText.toLowerCase());
        }).toList();
      },
    );

    if (filteredTracabilte.isEmpty && failureOrTracabilte.isLeft()) {
      final failure = failureOrTracabilte.fold((l) => l, (_) => null);
      emit(ErrorTracabilteState(message: _mapFailureToMessage(failure!)));
    } else {
      emit(LoadedTracabiliteState(tracabilte: filteredTracabilte));
    }
  }
  // filter by date range

  Future<void> _onFilterTracabiliteByDateRange(
    FilterTracabilteByDateRangeEvent event,
    Emitter<TracabilteState> emit,
  ) async {
    emit(LoadingTracabiliteState());

    final failureOrTracabilite = await getTracabiliteByDateUseCase(event.dateRange);
    emit(_mapFailureOrTracabiliteToState(failureOrTracabilite));
  }
  // filter

  Future<void> _onFilterTracabiltes(
    FilterTracabilteEvent event,
    Emitter<TracabilteState> emit,
  ) async {
    final failureOrTracabilte = await getAllTracabilteUseCase();

    failureOrTracabilte.fold(
      (failure) => emit(ErrorTracabilteState(message: _mapFailureToMessage(failure))),
      (tracabilte) {
        List<Tracabilte> filteredList;

        if (event.filterType == 'nom' && event.isAscending != null) {
          // Filter by name and sort based on isAscending
          filteredList = tracabilte.where((item) => item.name.isNotEmpty).toList();
          if (event.isAscending!) {
            filteredList.sort((a, b) => a.name.compareTo(b.name));
          } else {
            filteredList.sort((a, b) => b.name.compareTo(a.name));
          }
        } else if (event.filterType == 'quantite') {
          // Filter by non-zero Quantite and sort from min to max
          filteredList = tracabilte.where((item) => item.quantite > 0).toList()..sort((a, b) => a.quantite.compareTo(b.quantite));
        } else {
          // Default case: no filtering, return the entire list
          filteredList = tracabilte;
        }

        // Emit the filtered list
        emit(LoadedTracabiliteState(tracabilte: filteredList));
      },
    );
  }

  // on refresh

  Future<void> _onRefreshTracabilite(RefreshTracabilteEvent event, Emitter<TracabilteState> emit) async {
    emit(LoadingTracabiliteState());
    final failureOrTracabilte = await getAllTracabilteUseCase();
    emit(_mapFailureOrTracabiliteToState(failureOrTracabilte));
  }

  TracabilteState _mapFailureOrTracabiliteToState(Either<Failure, List<Tracabilte>> either) {
    return either.fold(
      (failure) => ErrorTracabilteState(message: _mapFailureToMessage(failure)),
      (tracabilte) => LoadedTracabiliteState(tracabilte: tracabilte),
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
}
