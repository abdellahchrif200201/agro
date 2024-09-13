import "dart:async";
import "dart:convert";
import "package:dartz/dartz.dart";
import "package:devti_agro/core/error/exeptions.dart";
import "package:devti_agro/features/chambre/application/models/chambre_model.dart";
import "package:http/http.dart" as http;

import "../../../../core/api/api_route.dart";
import "../../../../core/utils/loger.dart";

abstract class ChambreRemoteDataSource {
  Future<List<ChambreModel>> getAllChambre(int page);
  Future<Unit> addChambre(ChambreModel chambreModel);
  Future<Unit> updateChambre(ChambreModel chambreModel);
  Future<Unit> deleteChambre(int idChambre);
}

class ChambreRemoteDataSourceImplement implements ChambreRemoteDataSource {
  final http.Client client;
  ChambreRemoteDataSourceImplement({required this.client});
  @override
  Future<List<ChambreModel>> getAllChambre(int page) async {
    final response = await client.get(
      Uri.parse("$BASE_URL/MOBILE/Chambre/1?page=$page"),
      headers: {
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);

      final List<dynamic> data = decodedJson['data'];
      final List<ChambreModel> chambresModel = data.map<ChambreModel>((jsonChambreModel) {
        return ChambreModel.fromJson({'data': jsonChambreModel, 'meta': decodedJson['meta']});
      }).toList();

      logger.d(decodedJson['meta']);

      return chambresModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addChambre(ChambreModel chambreModel) async {
    final body =
        jsonEncode({"Name": chambreModel.name, "EntrepriseICE": chambreModel.entrepriseICE, "ZoneId": chambreModel.zoneId, "Surface": chambreModel.surface, "Temperature": chambreModel.temperature});

    final response = await client.post(
      Uri.parse("$BASE_URL/MOBILE/Chambre"),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      logger.d("created succseful");

      logger.d(responseBody);

      if (responseBody["status"] == 201) {
        // Login successful, save the token

        logger.d(responseBody);
        logger.d("create sucsses");
        return Future.value(unit);
      } else {
        // Handle unexpected response codes or messages
        throw ServerException(message: responseBody["message  "] ?? "Unexpected error");
      }
    } else {
      logger.d("no create chambres");
      final errorMessage = responseBody["error"] ?? "Server error";
      throw ServerException(message: errorMessage);
    }
  }

  @override
  Future<Unit> deleteChambre(int idChambre) async {
    final response = await client.delete(
      Uri.parse("$BASE_URL/WEB/Chambre/${idChambre.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateChambre(ChambreModel chambreModel) async {
    final chambreId = chambreModel.id.toString();
    final chambreZONE = chambreModel.zoneId.toString();

    logger.d("chambre id $chambreId");
    logger.d("zone id $chambreZONE ");

    final body = jsonEncode({"Name": chambreModel.name, "ZoneId": chambreModel.zoneId, "Surface": chambreModel.surface, "Temperature": chambreModel.temperature});

    final response = await client.put(
      Uri.parse("$BASE_URL/WEB/Chambre/$chambreId"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      logger.d(response.body);
      return Future.value(unit);
    } else {
      logger.d(response.body);

      throw ServerException();
    }
  }
}
