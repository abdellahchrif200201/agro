import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/features/user/aplication/usecase/user_use_case.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:devti_agro/core/error/failures.dart';

// Define events
part 'user_event.dart';

// Define states
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase userUseCase;

  UserBloc({required this.userUseCase}) : super(UserInitial()) {
    on<GetAllUserEvent>(_onGetAllUser);
    on<RefreshUserEvent>(_onRefreshUsers);
    on<SearchUserEvent>(_onSearchUser);
  }

  Future<void> _onGetAllUser(
    GetAllUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(LoadingUserState());

    final failureOrUser = await userUseCase.call();
    emit(_mapFailureOrUserToState(failureOrUser));
  }


  Future<void> _onRefreshUsers(
    RefreshUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(LoadingUserState());

    final failureOrUser = await userUseCase();
    emit(_mapFailureOrUserToState(failureOrUser));
  }


  Future<void> _onSearchUser(
    SearchUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(LoadingUserState());

    final failureOrUser = await userUseCase();

    final filteredUser = failureOrUser.fold(
      (failure) => <User>[], // Return an empty list on failure
      (chambres) {
        final chambreList = chambres.cast<User>();
        return chambreList.where((chambre) {
          return chambre.name.toLowerCase().contains(event.searchText.toLowerCase());
        }).toList();
      },
    );
    if (filteredUser.isEmpty && failureOrUser.isLeft()) {
      final failure = failureOrUser.fold((l) => l, (_) => null);
      emit(ErrorUserState(message: _mapFailureToMessage(failure!)));
    } else {
      emit(LoadedUserState(users: filteredUser));
    }
  }

  UserState _mapFailureOrUserToState(
    Either<Failure, List<User>> either,
  ) {
    return either.fold(
      (failure) => ErrorUserState(message: _mapFailureToMessage(failure)),
      (user) => LoadedUserState(users: user),
    );
  }


  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    } else if (failure is OfflineFailure) {
      return 'Offline Failure';
    } else {
      print('Unknown Failure: ${failure.runtimeType}');
      return 'Unexpected Error';
    }
  }
}

