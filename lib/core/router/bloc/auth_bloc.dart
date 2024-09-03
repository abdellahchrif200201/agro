// auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthEvent>((event, emit) async {
      // Simulate a delay for checking the token
      await Future.delayed(const Duration(seconds: 2));

      // Check if the token is present
      final bool isTokenPresent = await _isTokenPresent();

      if (isTokenPresent) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<bool> _isTokenPresent() async {
    // Add logic to check if the token is present
    // For example, using SharedPreferences:
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("auth_token");
  }
}
