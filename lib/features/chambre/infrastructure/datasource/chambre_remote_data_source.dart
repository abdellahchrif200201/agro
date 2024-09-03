import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/chambre/application/models/chambre_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_route.dart';

abstract class ChambreRemoteDataSource {
  Future<List<ChambreModel>> getAllChambre(int? page);
  Future<Unit> addChambre(ChambreModel chambreModel);
}

class ChambreRemoteDataSourceImplement implements ChambreRemoteDataSource {
  final http.Client client;
  ChambreRemoteDataSourceImplement({required this.client});
  @override
  Future<List<ChambreModel>> getAllChambre(int? page) async {
    final response = await client.get(
      Uri.parse("$BASE_URL/MOBILE/Chambre/1?page=2"),
      headers: {
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = decodedJson['data'];

      final List<ChambreModel> chambresModel = data.map<ChambreModel>((jsonChambreModel) => ChambreModel.fromJson(jsonChambreModel)).toList();

      return chambresModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addChambre(ChambreModel chambreModel) async {
    final body =
        jsonEncode({"Name": chambreModel.name, "EntrepriseICE": chambreModel.entrepriseICE, 'ZoneId': chambreModel.zoneId, 'Surface': chambreModel.surface, 'Temperature': chambreModel.temperature});

    final response = await client.post(
      Uri.parse('$BASE_URL/MOBILE/Chambre'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("created succseful");

      if (responseBody["status"] == 201) {
        // Login successful, save the token

        print(responseBody);
        print("create sucsses");
        return Future.value(unit);
      } else {
        // Handle unexpected response codes or messages
        throw ServerException(message: responseBody['message  '] ?? 'Unexpected error');
      }
    } else {
      print("no create chambres");
      final errorMessage = responseBody['error'] ?? 'Server error';
      throw ServerException(message: errorMessage);
    }
  }
}
