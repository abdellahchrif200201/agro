import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:intl/intl.dart'; // For date formatting

class ChambreModel extends Chambre {
  ChambreModel(
      {super.id,
      required super.name,
      super.zoneName,
      super.entrepriseName,
      required super.surface,
      required super.temperature,
      super.createdAt,
      super.entrepriseICE,
      super.zoneId,
      super.pageCurrent,
      super.pageFrom,
      super.lastPage});

  factory ChambreModel.fromJson(Map<String, dynamic> json) {
    // Extract data and meta fields from the JSON
    final data = json['data'];
    final meta = json['meta'];

    return ChambreModel(
      id: data['id'] as int?,
      name: data['Name'] as String,
      zoneName: data['Zone']?['name'] as String?,
      entrepriseName: data['Entreprise']?['name'] as String?,
      surface: (data['Surface'] as num).toDouble(),
      temperature: (data['Temperature'] as num).toDouble(),
      createdAt: data['created_at'] as String?,
      entrepriseICE: data['Entreprise']['id'] as int,
      zoneId: data['Zone']?['id'] as int?,
      pageCurrent: meta['current_page'] as int?,
      pageFrom: meta['from'] as int?,
      lastPage: meta['last_page'] as int?,
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
