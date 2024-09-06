import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/chambre/application/use_cases/delete_chambre_use_case.dart';
import 'package:devti_agro/features/chambre/application/use_cases/update_chambre_use_case.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:equatable/equatable.dart';

part 'delete_update_chambre_event.dart';
part 'delete_update_chambre_state.dart';

class AddDeleteUpdateChambreBloc extends Bloc<DeleteUpdateChambreEvent, DeleteUpdateChambreState> {
  final DeleteChambreUseCase deleteChambreUseCase;
  final UpdateChambreUseCase updateChambreUseCase;

  AddDeleteUpdateChambreBloc({required this.deleteChambreUseCase , required this.updateChambreUseCase}) : super(DeleteUpdateChambreInitial()) {
    on<DeleteUpdateChambreEvent>((event, emit) async {
       if (event is UpdateChambreEvent) {
        emit(LoadingDeleteUpdateChambreState());

        final failureOrDoneMessage = await updateChambreUseCase(event.chambre);

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeleteChambreEvent) {
        emit(LoadingDeleteUpdateChambreState());

        final failureOrDoneMessage = await deleteChambreUseCase(event.chambreId);

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }

  DeleteUpdateChambreState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorDeleteUpdateChambreState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageDeleteUpdateChambreState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
