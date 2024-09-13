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
    super.lastPage,
    super.pageCurrent,
    super.pageFrom,
  });

  /// Creates a new instance of [UserModel] from a JSON object.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final meta = json['meta'];
    return UserModel(
      id: data['id'] as int?,
      name: data['name'] as String,
      adresse: data['adresse'] as String?,
      email: data['email'] as String?,
      image: data['image'] as String?,
      pays: data['pays'] as String?,
      telephone: data['telephone'] as String?,
      ville: data['ville'] as String?,
      entrepriseId: data['Entreprise']['id'] as int,
      pageCurrent: meta['current_page'] as int?,
      pageFrom: meta['from'] as int?,
      lastPage: meta['last_page'] as int?,
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
