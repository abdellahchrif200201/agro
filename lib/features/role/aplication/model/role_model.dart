import 'package:devti_agro/features/role/domain/entities/role.dart';


/// Model class for Zone which extends Zone entity.
class RoleModel extends Role {
  RoleModel({
    required super.id,
    required super.name,
    required super.guardName,
  });

  /// Creates a new instance of [RoleModel] from a JSON object.
  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      name: json['name'],
      guardName: json['guard_name'],
    );
  }
}
