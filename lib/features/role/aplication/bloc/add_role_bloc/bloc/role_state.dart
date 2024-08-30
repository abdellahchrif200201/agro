part of 'role_bloc.dart';

sealed class RoleState extends Equatable {
  const RoleState();
  
  @override
  List<Object> get props => [];
}

final class RoleInitial extends RoleState {}

class LoadingRoleState extends RoleState {}

class LoadedRoleState extends RoleState {
  final List<Role> roles;

  const LoadedRoleState({required this.roles});

  @override
  List<Object> get props => [roles];
}

class ErrorRoleState extends RoleState {
  final String message;

  const ErrorRoleState({required this.message});

  @override
  List<Object> get props => [message];
}
