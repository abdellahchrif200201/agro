import 'package:devti_agro/features/zone/domain/entities/zone.dart';

/// Model class for Zone which extends Zone entity.
class ZoneModel extends Zone {
  ZoneModel({
    required super.id,
    required super.name,
    required super.description,
  });

  /// Creates a new instance of [ZoneModel] from a JSON object.
  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id'],
      name: json['Name'],
      description: json['Description'],
    );
  }
}
