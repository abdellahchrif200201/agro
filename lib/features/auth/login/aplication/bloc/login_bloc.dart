import 'package:bloc/bloc.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/auth/login/domain/entities/login.dart';
import 'package:devti_agro/features/auth/login/aplication/useCase/login_usse_case.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final login = Login(email: event.email, password: event.password);

    final failureOrSuccess = await loginUseCase(login);

    emit(
      failureOrSuccess.fold(
        (failure) {
          final errorMessage = _mapFailureToMessage(failure);
          print('Login Error: $errorMessage'); // Print the error message
          return LoginFailure(message: errorMessage);
        },
        (_) => LoginSuccess(),
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
