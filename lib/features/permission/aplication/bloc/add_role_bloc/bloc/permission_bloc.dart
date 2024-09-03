import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/features/permission/aplication/usecase/Permission_use_case.dart';
import 'package:devti_agro/features/permission/domain/entities/permission.dart';
import 'package:equatable/equatable.dart';
import 'package:devti_agro/core/error/failures.dart';

// Define events
part 'permission_event.dart';

// Define states
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  final PermissionUseCase permissionUseCase;

  PermissionBloc({required this.permissionUseCase}) : super(PermissionInitial()) {
    on<GetAllPermissionEvent>(_onGetAllPermission);
  }

  Future<void> _onGetAllPermission(
    GetAllPermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    emit(LoadingPermissionState());

    final failureOrPermission = await permissionUseCase.call();
    emit(_mapFailureOrPermissionToState(failureOrPermission));
  }

  PermissionState _mapFailureOrPermissionToState(
    Either<Failure, List<Permission>> either,
  ) {
    return either.fold(
      (failure) => ErrorPermissionState(message: _mapFailureToMessage(failure)),
      (permissions) => LoadedPermissionState(permissions: permissions),
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
