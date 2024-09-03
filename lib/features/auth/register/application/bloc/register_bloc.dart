import 'package:bloc/bloc.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/auth/register/domain/entities/register.dart';
import 'package:devti_agro/features/auth/register/application/usecase/register_use_case.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase}) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onregisterButtonPressed);
  }

  Future<void> _onregisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    final register = Register(name: event.name,email: event.email, password: event.password ,entrepriseICE: event.entrepriseICE);

    final failureOrSuccess = await registerUseCase(register);

    emit(
      failureOrSuccess.fold(
        (failure) {
          final errorMessage = _mapFailureToMessage(failure);
          print('register Error: $errorMessage'); // Print the error message
          return RegisterFailure(message: errorMessage);
        },
        (_) => RegisterSuccess(),
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
