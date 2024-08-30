import 'package:devti_agro/features/auth/login/domain/entities/login.dart';

class LoginModel extends Login {
  LoginModel({
    required String email,
    required String password,
  }) : super(email: email, password: password);

  // Convert a LoginModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Create a LoginModel instance from a Map
  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
