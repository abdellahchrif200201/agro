part of 'permission_bloc.dart';

sealed class PermissionState extends Equatable {
  const PermissionState();
  
  @override
  List<Object> get props => [];
}

final class PermissionInitial extends PermissionState {}

class LoadingPermissionState extends PermissionState {}

class LoadedPermissionState extends PermissionState {
  final List<Permission> permissions;

  const LoadedPermissionState({required this.permissions});

  @override
  List<Object> get props => [permissions];
}

class ErrorPermissionState extends PermissionState {
  final String message;

  const ErrorPermissionState({required this.message});

  @override
  List<Object> get props => [message];
}
