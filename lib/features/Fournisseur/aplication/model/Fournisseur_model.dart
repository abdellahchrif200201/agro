import 'package:devti_agro/features/Fournisseur/domain/entities/Fournisseur.dart';

/// Model class for Zone which extends Zone entity.
class FournisseurModel extends Fournisseur {
  FournisseurModel({
    required super.id,
    required super.name,
    required super.email,
  });

  /// Creates a new instance of [FournisseurModel] from a JSON object.
  factory FournisseurModel.fromJson(Map<String, dynamic> json) {
    return FournisseurModel(
      id: json['id'],
      name: json['Name'],
      email: json['Email'],
    );
  }
}
