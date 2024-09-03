import 'package:devti_agro/features/permission/domain/entities/permission.dart';


/// Model class for Zone which extends Zone entity.
class PermissionModel extends Permission {
  PermissionModel({
    required super.id,
    required super.name,
    required super.guardName,
  });

  /// Creates a new instance of [PermissionModel] from a JSON object.
  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      id: json['id'],
      name: json['name'],
      guardName: json['guard_name'],
    );
  }
}
