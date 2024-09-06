import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/get_all_check_list_use_case.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/get_check_list_by_date_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'check_list_event.dart';
part 'check_list_state.dart';

class CheckListBloc extends Bloc<CheckListEvent, CheckListState> {
  final GetAllCheckListUseCase getAllCheckListUseCase;
  final GetCheckListByDateUseCase getCheckListByDateUseCase;

  CheckListBloc({required this.getAllCheckListUseCase, required this.getCheckListByDateUseCase}) : super(CheckListInitial()) {
    // Directly register event handlers in the constructor
    on<GetAllCheckListEvent>(_onGetAllCheckList);
    on<RefreshCkeckListEvent>(_onRefreshCheckLists);
    on<FilterCheckListByDateRangeEvent>(_onFilterCheckListByDateRange);
    on<SearchCheckListEvent>(_onSearchCheckList);
    on<FilterCheckListEvent>(_onFilterCheckLists);
  }

  // Get all check lists
  Future<void> _onGetAllCheckList(
    GetAllCheckListEvent event,
    Emitter<CheckListState> emit,
  ) async {
    emit(LoadingCheckListState());

    final failureOrCheckList = await getAllCheckListUseCase();
    emit(_mapFailureOrCheckListsToState(failureOrCheckList));
  }

  // Refresh check lists
  Future<void> _onRefreshCheckLists(
    RefreshCkeckListEvent event,
    Emitter<CheckListState> emit,
  ) async {
    emit(LoadingCheckListState());

    final failureOrCheckList = await getAllCheckListUseCase();
    emit(_mapFailureOrCheckListsToState(failureOrCheckList));
  }

  // Map failure or success to state
  CheckListState _mapFailureOrCheckListsToState(
    Either<Failure, List<CheckList>> either,
  ) {
    return either.fold(
      (failure) => ErrorCheckListState(message: _mapFailureToMessage(failure)),
      (checkList) => LoadedCheckListState(checkList: checkList),
    );
  }

  // Map failures to messages
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

  Future<void> _onFilterCheckListByDateRange(
    FilterCheckListByDateRangeEvent event,
    Emitter<CheckListState> emit,
  ) async {
    emit(LoadingCheckListState());

    final failureOrCheckList = await getCheckListByDateUseCase(event.dateRange);
    emit(_mapFailureOrCheckListsToState(failureOrCheckList));
  }

  // Future => search by name

  Future<void> _onSearchCheckList(
    SearchCheckListEvent event,
    Emitter<CheckListState> emit,
  ) async {
    emit(LoadingCheckListState());

    final failureOrCheckList = await getAllCheckListUseCase();

    final filteredCheckList = failureOrCheckList.fold(
      (failure) => <CheckList>[], // Return an empty list on failure
      (checkList) {
        final checkListList = checkList.cast<CheckList>();
        return checkListList.where((checkList) {
          return checkList.tasksName!.toLowerCase().contains(event.searchText.toLowerCase());
        }).toList();
      },
    );

    if (filteredCheckList.isEmpty && failureOrCheckList.isLeft()) {
      final failure = failureOrCheckList.fold((l) => l, (_) => null);
      emit(ErrorCheckListState(message: _mapFailureToMessage(failure!)));
    } else {
      emit(LoadedCheckListState(checkList: filteredCheckList));
    }
  }

  // filter menu

  Future<void> _onFilterCheckLists(
    FilterCheckListEvent event,
    Emitter<CheckListState> emit,
  ) async {
    final failureOrCheckList = await getAllCheckListUseCase();

    failureOrCheckList.fold(
      (failure) => emit(ErrorCheckListState(message: _mapFailureToMessage(failure))),
      (checkList) {
        List<CheckList> filteredList;

        if (event.filterType == 'nom' && event.isAscending != null) {
          filteredList = checkList.where((item) => item.tasksName!.isNotEmpty).toList();
          if (event.isAscending!) {
            filteredList.sort((a, b) => a.tasksName!.compareTo(b.tasksName!));
          } else {
            filteredList.sort((a, b) => b.tasksName!.compareTo(a.tasksName!));
          }
        } else if (event.filterType == 'date') {
          // Filter by non-empty date and sort from max to min

          filteredList = checkList.where((item) => item.date!.isNotEmpty).toList();
          if (event.isAscending!) {
            filteredList.sort((a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)));
          } else {
            filteredList.sort((a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
          }
        } else {
          filteredList = checkList;
        }

        emit(LoadedCheckListState(checkList: filteredList));
      },
    );
  }
}
