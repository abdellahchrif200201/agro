import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/user/aplication/usecase/add_user_use_case.dart';
import 'package:devti_agro/features/user/aplication/usecase/delete_user_use_case.dart';
import 'package:devti_agro/features/user/aplication/usecase/update_user_use_case.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

part 'delete_add_update_user_event.dart';
part 'delete_add_update_user_state.dart';

class AddDeleteUpdateUserBloc extends Bloc<AddDeleteUpdateUserEvent, AddDeleteUpdateUserState> {
  final AddUserUseCase addUser;
  final DeleteUserUseCase deleteUser;
  final UpdateUserUsecase updateUser;
  AddDeleteUpdateUserBloc({
    required this.deleteUser,
    required this.addUser,
    required this.updateUser
  }) : super(AddDeleteUpdateUserInitial()) {
    on<AddDeleteUpdateUserEvent>((event, emit) async {
      if (event is AddUserEvent) {
        emit(LoadingAddDeleteUpdateUserState());

        final failureOrDoneMessage = await addUser(event.user);

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      }
      else if (event is UpdateUserEvent) {
        emit(LoadingAddDeleteUpdateUserState());

        final failureOrDoneMessage = await updateUser(event.user);

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } 
      
       else if (event is DeleteUserEvent) {
        emit(LoadingAddDeleteUpdateUserState());

        final failureOrDoneMessage = await deleteUser(event.userId);

        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }

  AddDeleteUpdateUserState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateUserState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdateUserState(message: message),
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
