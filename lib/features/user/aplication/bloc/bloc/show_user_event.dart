part of 'show_user_bloc.dart';

sealed class ShowUserEvent extends Equatable {
  const ShowUserEvent();

  @override
  List<Object> get props => [];
}

final class FetchUserEvent extends ShowUserEvent {
  final int userId;

  const FetchUserEvent(this.userId);

  @override
  List<Object> get props => [userId];
}