import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/add_tache_use_case.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/delete_tache_use_case.dart';
import 'package:devti_agro/features/Checklist/application/use_cases/update_check_list_use_case.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_tache_event.dart';
part 'add_delete_update_tache_state.dart';

class AddDeleteUpdateTacheBloc extends Bloc<AddDeleteUpdateTacheEvent, AddDeleteUpdateTacheState> {
  final AddTacheUseCase addTache;
  final DeleteTacheUseCase deleteTache;
  final UpdateTacheUsecase updateTache;
  AddDeleteUpdateTacheBloc({required this.addTache ,required this.deleteTache , required this.updateTache}) : super(AddDeleteUpdateTacheInitial()) {
    on<AddDeleteUpdateTacheEvent>((event, emit) async {
      if (event is AddTacheEvent) {
        emit(LoadingAddDeleteUpdateTacheState());

        final failureOrDoneMessage = await addTache(event.tache);

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      }
       else if (event is UpdateTacheEvent) {
        emit(LoadingAddDeleteUpdateTacheState());

        final failureOrDoneMessage = await updateTache(event.tache);

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      }
      else if (event is DeleteTacheEvent) {
        emit(LoadingAddDeleteUpdateTacheState());

        final failureOrDoneMessage = await deleteTache(event.tacheId);

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }

  AddDeleteUpdateTacheState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateTacheState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdateTacheState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
