import 'package:devti_agro/features/Etiquetage/domain/entities/etiquetage.dart';

class EtiquetageModel extends Etiquetage {
  EtiquetageModel({
    required super.id,
    required super.name,
    required super.type,
    required super.category,
    required super.dateDDM,
    required super.dateDLC,
  });

  // Factory constructor to create an instance from JSON
  factory EtiquetageModel.fromJson(Map<String, dynamic> json) {
    return EtiquetageModel(
      id: json['id'],
      name: json['Name'],
      type: json['Category'], // Provide a default value if type is missing
      category: json['Category'],
      dateDDM: json['DDMDate'],
      dateDLC: json['DLCDate'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'type': type,
      'Category': category,
      'DDMDate': dateDDM,
      'DLCDate': dateDLC,
    };
  }
}
