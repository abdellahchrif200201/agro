part of 'show_user_bloc.dart';


sealed class ShowUserState extends Equatable {
  const ShowUserState();

  @override
  List<Object> get props => [];
}

final class ShowUserInitial extends ShowUserState {}

final class ShowUserLoading extends ShowUserState {}

final class ShowUserLoaded extends ShowUserState {
  final User user;

  const ShowUserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class ShowUserError extends ShowUserState {
  final String message;

  const ShowUserError(this.message);

  @override
  List<Object> get props => [message];
}
