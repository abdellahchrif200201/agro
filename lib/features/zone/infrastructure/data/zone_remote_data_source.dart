import 'dart:convert';

import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/zone/aplication/model/zone_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_route.dart';

abstract class ZoneRemoteDataSource {
  Future<List<ZoneModel>> getAllZoneByEntreprise(int idEntreprise);
}


class ZoneRemoteDataSourceImplement implements ZoneRemoteDataSource {
  final http.Client client;
  ZoneRemoteDataSourceImplement({required this.client});
  @override
  Future<List<ZoneModel>> getAllZoneByEntreprise(int idEntreprise) async {
    final response = await client.get(
      Uri.parse("$BASE_URL/MOBILE/Zone/$idEntreprise"),
      headers: {
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson =
          json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = decodedJson['data'];

      final List<ZoneModel> zoneModel = data
          .map<ZoneModel>(
              (jsonZoneModel) => ZoneModel.fromJson(jsonZoneModel))
          .toList();

      return zoneModel;
    } else {
      throw ServerException();
    }
  }
}
