import 'package:devti_agro/features/user/domain/entities/user.dart';

/// Model class for User which extends User entity.
class UserModel extends User {
  UserModel({
    super.id,
    required super.name,
    super.adresse,
    super.email,
    super.image,
    super.password,
    super.pays,
    super.telephone,
    super.ville,
    required super.entrepriseId,
  });

  /// Creates a new instance of [UserModel] from a JSON object.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      adresse: json['adresse'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      pays: json['pays'] as String?,
      telephone: json['telephone'] as String?,
      ville: json['ville'] as String?,
      entrepriseId: json['Entreprise']['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'adresse': adresse,
      'email': email,
      'image': image,
      'pays': pays,
      'telephone': telephone,
      'ville': ville,
      'entrepriseId': entrepriseId,
    };
  }
}
