import 'package:devti_agro/features/Tracbalite/domain/entities/tracabilite.dart';

class TracabiliteModel extends Tracabilte {
  TracabiliteModel({
    required super.id,
    required super.name,
    required super.unite,
    required super.quantite,
    required super.nutrition,
    required super.dateCreate,
  });

  factory TracabiliteModel.fromJson(Map<String, dynamic> json) {
    return TracabiliteModel(
      id: json['id'],
      name: json['User']['name'], // Assuming the 'name' comes from 'Nutrition'
      unite: json['Unite'],
      quantite: json['Quantite'],
      nutrition: json['Nutrition']['Name'],
      dateCreate: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Nutrition': nutrition,
      'Unite': unite,
      'Quantite': quantite,
      'name' : name,
      'created_at' : dateCreate
    };
  }
}
