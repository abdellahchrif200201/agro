import 'dart:convert';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/Fournisseur/aplication/model/Fournisseur_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_route.dart';

abstract class FournisseurRemoteDataSource {
  Future<List<FournisseurModel>> getAllFournisseur();
}

class FournisseurRemoteDataSourceImplement implements FournisseurRemoteDataSource {
  final http.Client client;
  FournisseurRemoteDataSourceImplement({required this.client});
  @override
  Future<List<FournisseurModel>> getAllFournisseur() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/WEB/Fournisseur/1"),
      headers: {
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> decodedJson = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = decodedJson['data'];

      final List<FournisseurModel> roleModel = data.map<FournisseurModel>((jsonFournisseurModel) => FournisseurModel.fromJson(jsonFournisseurModel)).toList();

      return roleModel;
    } else {
       print(response.body);
      throw ServerException();
    }
  }
}
