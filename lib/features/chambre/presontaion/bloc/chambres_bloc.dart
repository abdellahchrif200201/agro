import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:devti_agro/features/chambre/domain/use_cases/GetChambresByDateRangeUseCase.dart';
import 'package:devti_agro/features/chambre/domain/use_cases/get_all_chambre.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'chambres_event.dart';
part 'chambres_state.dart';

class ChambresBloc extends Bloc<ChambresEvent, ChambresState> {
  final GetAllChambresUseCase getAllChambres;
  final GetChambresByDateRangeUseCase getChambresByDateRange;

  // constricteur

  ChambresBloc({
    required this.getAllChambres,
    required this.getChambresByDateRange,
  }) : super(ChambresInitial()) {
    on<GetAllChambresEvent>(_onGetAllChambres);
    on<RefreshChambresEvent>(_onRefreshChambres);
    on<FilterChambresByDateRange>(_onFilterChambresByDateRange);
    on<SearchChambresEvent>(_onSearchChambres);
    on<FilterChambresEvent>(_onFilterChambres);
  }

  // future get all chambres

  Future<void> _onGetAllChambres(
    GetAllChambresEvent event,
    Emitter<ChambresState> emit,
  ) async {
    emit(LoadingChambresState());

    final failureOrChambres = await getAllChambres();
    emit(_mapFailureOrChambresToState(failureOrChambres));
  }

  // future refresh chambres

  Future<void> _onRefreshChambres(
    RefreshChambresEvent event,
    Emitter<ChambresState> emit,
  ) async {
    emit(LoadingChambresState());

    final failureOrChambres = await getAllChambres();
    emit(_mapFailureOrChambresToState(failureOrChambres));
  }

  // future => refresh by date

  Future<void> _onFilterChambresByDateRange(
    FilterChambresByDateRange event,
    Emitter<ChambresState> emit,
  ) async {
    emit(LoadingChambresState());

    final failureOrChambres = await getChambresByDateRange(event.dateRange);
    emit(_mapFailureOrChambresToState(failureOrChambres));
  }

  // Future => search by name

  Future<void> _onSearchChambres(
    SearchChambresEvent event,
    Emitter<ChambresState> emit,
  ) async {
    emit(LoadingChambresState());

    final failureOrChambres = await getAllChambres();

    final filteredChambres = failureOrChambres.fold(
      (failure) => <Chambre>[], // Return an empty list on failure
      (chambres) {
        final chambreList = chambres.cast<Chambre>();
        return chambreList.where((chambre) {
          return chambre.name.toLowerCase().contains(event.searchText.toLowerCase());
        }).toList();
      },
    );

    if (filteredChambres.isEmpty && failureOrChambres.isLeft()) {
      final failure = failureOrChambres.fold((l) => l, (_) => null);
      emit(ErrorChambresState(message: _mapFailureToMessage(failure!)));
    } else {
      emit(LoadedChambresState(chambres: filteredChambres));
    }
  }

  // failure or chambres

  ChambresState _mapFailureOrChambresToState(
    Either<Failure, List<Chambre>> either,
  ) {
    return either.fold(
      (failure) => ErrorChambresState(message: _mapFailureToMessage(failure)),
      (chambres) => LoadedChambresState(chambres: chambres),
    );
  }

  // message failure

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure is OfflineFailure) {
      return OFFLINE_FAILURE_MESSAGE;
    } else {
      print('Unknown Failure: ${failure.runtimeType}');
      return SERVER_FAILURE_MESSAGE1;
    }
  }

  // filter

  Future<void> _onFilterChambres(
    FilterChambresEvent event,
    Emitter<ChambresState> emit,
  ) async {
    final failureOrChambre = await getAllChambres();

    failureOrChambre.fold(
      (failure) => emit(ErrorChambresState(message: _mapFailureToMessage(failure))),
      (chambre) {
        List<Chambre> filteredList;

        if (event.filterType == 'nom' && event.isAscending != null) {
          // Filter by name and sort based on isAscending
          filteredList = chambre.where((item) => item.name.isNotEmpty).toList();
          if (event.isAscending!) {
            filteredList.sort((a, b) => a.name.compareTo(b.name)); // temperature , surface
          } else {
            filteredList.sort((a, b) => b.name.compareTo(a.name));
          }
        } else if (event.filterType == 'temperature') {
          // Filter by non-zero Quantite and sort from min to max
          filteredList = chambre.where((item) => item.temperature > 0 || item.temperature <= 0).toList();

          if (event.isAscending!) {
            filteredList.sort((a, b) => a.temperature.compareTo(b.temperature)); // temperature , temperature
          } else {
            filteredList.sort((a, b) => b.temperature.compareTo(a.temperature));
          }
        } else if (event.filterType == 'surface') {
          filteredList = chambre.where((item) => item.surface > 0).toList();
          if (event.isAscending!) {
            filteredList.sort((a, b) => a.surface.compareTo(b.surface)); // temperature , surface
          } else {
            filteredList.sort((a, b) => b.surface.compareTo(a.surface));
          }
        } else {
          // Default case: no filtering, return the entire list
          filteredList = chambre;
        }

        // Emit the filtered list
        emit(LoadedChambresState(chambres: filteredList));
      },
    );
  }
}
