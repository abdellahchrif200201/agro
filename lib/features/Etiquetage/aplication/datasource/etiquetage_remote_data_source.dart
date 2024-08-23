import 'dart:convert';
import 'package:devti_agro/features/Etiquetage/aplication/models/etiquetage_model.dart';
import 'package:http/http.dart' as http;

abstract class EtiquetageRemoteDataSource {
  Future<List<EtiquetageModel>> getAllEtiquetage();
}

const BASE_URL = "https://agroapp.devtitechnologie.pro/api/MOBILE/Nutrition";

class EtiquetageRemoteDataSourceImplement implements EtiquetageRemoteDataSource {
  final http.Client client;

  EtiquetageRemoteDataSourceImplement({required this.client});

  @override
  Future<List<EtiquetageModel>> getAllEtiquetage() async {
    final response = await client.get(
      Uri.parse(BASE_URL),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeJson = json.decode(response.body);
      final List<dynamic> data = decodeJson['data'];
      final List<EtiquetageModel> etiquetageModel = data.map<EtiquetageModel>(
              (jsonEtiquetageModel) => EtiquetageModel.fromJson(jsonEtiquetageModel)
      ).toList(); // Corrected this part to properly convert to List
      return etiquetageModel;
    } else {
      throw Exception("Failed to load etiquetage");
    }
  }
}
