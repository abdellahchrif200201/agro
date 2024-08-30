import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:intl/intl.dart'; // For date formatting

class ChambreModel extends Chambre {
  ChambreModel({
    super.id,
    required super.name,
    super.zoneName,
    super.entrepriseName,
    required super.surface,
    required super.temperature,
    super.createdAt,
    super.entrepriseICE,
    super.zoneId,
  });

  factory ChambreModel.fromJson(Map<String, dynamic> json) {
    return ChambreModel(
      id: json['id'] as int?,
      name: json['Name'] as String,
      zoneName: json['Zone']?['name'] as String?,
      entrepriseName: json['Entreprise']?['name'] as String?,
      surface: (json['Surface'] as num).toDouble(),
      temperature: (json['Temperature'] as num).toDouble(),
      createdAt: json['created_at'] as String?,
      entrepriseICE:  json['Entreprise']['id'] as int,
      zoneId:  json['Zone']?['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Zone': {'name': zoneName},
      'Entreprise': {'name': entrepriseName},
      'Surface': surface,
      'Temperature': temperature,
      'created_at': createdAt,
      'entreprise_ice': entrepriseICE,
      'zone_id': {'id': zoneId},
    };
  }

  DateTime? get createdAtDateTime {
    if (createdAt == null) return null;
    try {
      return DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(createdAt!);
    } catch (e) {
      return null;
    }
  }
}
