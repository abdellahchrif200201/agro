import 'dart:convert';
import 'package:bloc/bloc.dart';
// import 'package:devti_agro/features/user/aplication/model/user_model.dart';
import 'package:devti_agro/features/user/aplication/usecase/show_user_use_case.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';

part 'show_user_event.dart';
part 'show_user_state.dart';

class ShowUserBloc extends Bloc<ShowUserEvent, ShowUserState> {
  final ShowUserUseCase showUserUseCase;

  ShowUserBloc({required this.showUserUseCase}) : super(ShowUserInitial()) {
    on<FetchUserEvent>(_onFetchUser);
  }

  Future<void> _onFetchUser(FetchUserEvent event, Emitter<ShowUserState> emit) async {
    emit(ShowUserLoading());

    final Either<Failure, User> result = await showUserUseCase(event.userId);

    result.fold(
      (failure) {
        emit(ShowUserError("Failed to load user data"));
      },
      (user) async {
        final String userJson = jsonEncode(user);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', userJson);

        emit(ShowUserLoaded(user));
      },
    );
  }
}
