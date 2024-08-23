import 'dart:convert';

import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/chambre/application/models/chambre_model.dart';
import 'package:http/http.dart' as http;

abstract class ChambreRemoteDataSource {
  Future<List<ChambreModel>> getAllChambre();
}

const BASE_URL = "https://agroapp.devtitechnologie.pro/api";

class ChambreRemoteDataSourceImplement implements ChambreRemoteDataSource {
  final http.Client client;
  ChambreRemoteDataSourceImplement({required this.client});
  @override
  Future<List<ChambreModel>> getAllChambre() async {
    final response = await client.get(
      Uri.parse(BASE_URL + "/MOBILE/Chambre"),
      headers: {
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson =
          json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = decodedJson['data'];

      final List<ChambreModel> chambresModel = data
          .map<ChambreModel>(
              (jsonChambreModel) => ChambreModel.fromJson(jsonChambreModel))
          .toList();

      return chambresModel;
    } else {
      throw ServerException();
    }
  }
}
