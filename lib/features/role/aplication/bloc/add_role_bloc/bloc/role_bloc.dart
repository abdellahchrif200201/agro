import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/features/role/aplication/usecase/role_use_case.dart';
import 'package:devti_agro/features/role/domain/entities/role.dart';
import 'package:equatable/equatable.dart';
import 'package:devti_agro/core/error/failures.dart';

// Define events
part 'role_event.dart';

// Define states
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final RoleUseCase roleUseCase;

  RoleBloc({required this.roleUseCase}) : super(RoleInitial()) {
    on<GetAllRoleEvent>(_onGetAllRole);
  }

  Future<void> _onGetAllRole(
    GetAllRoleEvent event,
    Emitter<RoleState> emit,
  ) async {
    emit(LoadingRoleState());

    final failureOrRole = await roleUseCase.call();
    emit(_mapFailureOrRoleToState(failureOrRole));
  }

  RoleState _mapFailureOrRoleToState(
    Either<Failure, List<Role>> either,
  ) {
    return either.fold(
      (failure) => ErrorRoleState(message: _mapFailureToMessage(failure)),
      (role) => LoadedRoleState(roles: role),
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
