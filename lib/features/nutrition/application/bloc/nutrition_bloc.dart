import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/nutrition/domain/entities/nutrition.dart';
import 'package:devti_agro/features/nutrition/application/useCase/get_all_nutiration_use_case.dart';
import 'package:equatable/equatable.dart';
part 'nutrition_event.dart';
part 'nutrition_state.dart';

class NutritionBloc extends Bloc<NutritionEvent, NutritionState> {
  final GetAllNutirationUseCase getAllNutirationUseCase;

  NutritionBloc({required this.getAllNutirationUseCase}) : super(NutritionInitial()) {
    on<GetAllNutritionEvent>(_onGetAllNutrition);
    on<RefreshNutritionEvent>(_onRefreshNutrition);
  }

  // future get all tracabilte

  Future<void> _onGetAllNutrition(
    GetAllNutritionEvent event,
    Emitter<NutritionState> emit,
  ) async {
    emit(LoadingNutritionState());
    final failureOrNutrition = await getAllNutirationUseCase();
    emit(_mapFailureOrNutritionToState(failureOrNutrition));
  }

  // on refresh

  // Future<void> _onSearchTracabilte(
  //   SearchNutritionEvent event,
  //   Emitter<NutritionState> emit,
  // ) async {
  //   emit(LoadingNutritionState());

  //   final failureOrTracabilte = await getAllNutirationUseCase();

  //   final filteredTracabilte = failureOrTracabilte.fold(
  //     (failure) => <Tracabilte>[], // Return an empty list on failure
  //     (tracabilte) {
  //       final tracabilteList = tracabilte.cast<Tracabilte>();
  //       return tracabilteList.where((tracabilte) {
  //         return tracabilte.name.toLowerCase().contains(event.searchText.toLowerCase());
  //       }).toList();
  //     },
  //   );

  //   if (filteredTracabilte.isEmpty && failureOrTracabilte.isLeft()) {
  //     final failure = failureOrTracabilte.fold((l) => l, (_) => null);
  //     emit(ErrorNutritionState(message: _mapFailureToMessage(failure!)));
  //   } else {
  //     emit(LoadedNutritionState(tracabilte: filteredTracabilte));
  //   }
  // }
  // filter by date range

  // Future<void> _onFilterNutritionByDateRange(
  //   FilterTracabilteByDateRangeEvent event,
  //   Emitter<NutritionState> emit,
  // ) async {
  //   emit(LoadingNutritionState());

  //   final failureOrNutrition = await getNutritionByDateUseCase(event.dateRange);
  //   emit(_mapFailureOrNutritionToState(failureOrNutrition));
  // }
  // // filter

  // Future<void> _onFilterTracabiltes(
  //   FilterNutritionEvent event,
  //   Emitter<NutritionState> emit,
  // ) async {
  //   final failureOrTracabilte = await getAllNutirationUseCase();

  //   failureOrTracabilte.fold(
  //     (failure) => emit(ErrorNutritionState(message: _mapFailureToMessage(failure))),
  //     (tracabilte) {
  //       List<Tracabilte> filteredList;

  //       if (event.filterType == 'nom' && event.isAscending != null) {
  //         // Filter by name and sort based on isAscending
  //         filteredList = tracabilte.where((item) => item.name.isNotEmpty).toList();
  //         if (event.isAscending!) {
  //           filteredList.sort((a, b) => a.name.compareTo(b.name));
  //         } else {
  //           filteredList.sort((a, b) => b.name.compareTo(a.name));
  //         }
  //       } else if (event.filterType == 'quantite') {
  //         // Filter by non-zero Quantite and sort from min to max
  //         filteredList = tracabilte.where((item) => item.quantite > 0).toList()..sort((a, b) => a.quantite.compareTo(b.quantite));
  //       } else {
  //         // Default case: no filtering, return the entire list
  //         filteredList = tracabilte;
  //       }

  //       // Emit the filtered list
  //       emit(LoadedNutritionState(tracabilte: filteredList));
  //     },
  //   );
  // }

  // on refresh

  Future<void> _onRefreshNutrition(RefreshNutritionEvent event, Emitter<NutritionState> emit) async {
    emit(LoadingNutritionState());
    final failureOrNutrition = await getAllNutirationUseCase();
    emit(_mapFailureOrNutritionToState(failureOrNutrition));
  }

  NutritionState _mapFailureOrNutritionToState(Either<Failure, List<Nutrition>> either) {
    return either.fold(
      (failure) => ErrorNutritionState(message: _mapFailureToMessage(failure)),
      (nutrition) => LoadedNutritionState(nutrition: nutrition),
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
