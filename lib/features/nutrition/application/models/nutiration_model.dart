import 'package:devti_agro/features/nutrition/domain/entities/nutrition.dart';

class NutritionModel extends Nutrition {
  NutritionModel({
    required super.id,
    required super.name,
    required super.fournisseur,
    required super.barCode,
    required super.dateDLC,
    required super.dateDDM,
    required super.category,
    required super.description,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    return NutritionModel(
      id: json['id'],
      name: json['Name'], // Correctly mapping the 'Name' from JSON
      fournisseur: json['Fournisseur'] != null ? json['Fournisseur']['name'] : '', // Handling nested JSON for fournisseur
      barCode: json['BarCode'], // Assuming 'barCode' is a string, convert if needed
      dateDLC: json['DLCDate'], // Parsing date from JSON
      dateDDM: json['DDMDate'],
      category: json['Category'],
      description: json['Description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fournisseur': fournisseur,
      'barCode': barCode,
      'dateDLC': dateDLC,
      'dateDDM': dateDDM,
      'category': category,
      'description': description,
    };
  }
}
