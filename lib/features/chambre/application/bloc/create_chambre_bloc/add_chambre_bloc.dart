import 'package:bloc/bloc.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:devti_agro/features/chambre/application/use_cases/add_chambre_use_case.dart';
import 'package:equatable/equatable.dart';

part 'add_chambre_event.dart';
part 'add_chambre_state.dart';

class AddChambreBloc extends Bloc<AddChambreEvent, AddChambreState> {
  final AddChambreUseCase addChambreUseCase;

  AddChambreBloc({required this.addChambreUseCase}) : super(AddChambreInitial()) {
    // Register the event handlers here
    on<AddChambreButtonPressed>(_onAddChambreButtonPressed);
  }

  Future<void> _onAddChambreButtonPressed(
    AddChambreButtonPressed event,
    Emitter<AddChambreState> emit,
  ) async {
    emit(AddChambreLoading());
    
    final failureOrSuccess = await addChambreUseCase(event.chambre);

    emit(
      failureOrSuccess.fold(
        (failure) {
          final errorMessage = _mapFailureToMessage(failure);
          print('AddChambre Error: $errorMessage'); // Print the error message
          return AddChambreFailure(message: errorMessage);
        },
        (_) => AddChambreSuccess(),
      ),
    );
  }

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
}
