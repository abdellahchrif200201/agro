import 'package:devti_agro/features/auth/register/domain/entities/register.dart';

class RegisterModel extends Register {
  RegisterModel({
    required super.name,
    required super.email,
    required super.password,
    required super.entrepriseICE,
    
  });

  // Convert a RegisterModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'entrepriseICE': entrepriseICE,
    };
  }

  // Create a RegisterModel instance from a Map
  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      entrepriseICE: map['entrepriseICE'],
     
    );
  }
}
