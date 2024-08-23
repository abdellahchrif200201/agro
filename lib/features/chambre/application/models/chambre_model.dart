import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:intl/intl.dart'; // For date formatting

class ChambreModel extends Chambre {
  ChambreModel({
    required super.id,
    required super.name,
    required super.zoneName,
    required super.entrepriseName,
    required super.surface,
    required super.temperature,
    required super.createdAt,
  });
  factory ChambreModel.fromJson(Map<String, dynamic> json) {
    return ChambreModel(
      id: json['id'],
      name: json['Name'],
      zoneName: json['Zone']['name'],
      entrepriseName: json['Entreprise']['name'],
      surface:  double.parse(json['Surface'].toString()),
      temperature: json['Temperature'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'Zone': {'name': zoneName},
      'Entreprise': {'name': entrepriseName},
      'Surface': surface,
      'Temperature': temperature,
      'created_at': createdAt
    };
  }

  DateTime get createdAtDateTime {
    return DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(createdAt);
  }
}
