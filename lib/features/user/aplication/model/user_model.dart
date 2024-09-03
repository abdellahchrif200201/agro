import 'package:devti_agro/features/user/domain/entities/user.dart';


/// Model class for Zone which extends Zone entity.
class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
  });

  /// Creates a new instance of [UserModel] from a JSON object.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
