part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final int entrepriseICE;
  final int phone;
  final String address;
  final String country;

  const RegisterButtonPressed({required this.name, required this.email, required this.password, required this.entrepriseICE, required this.address, required this.phone, required this.country});

  @override
  List<Object> get props => [email, password];
}
