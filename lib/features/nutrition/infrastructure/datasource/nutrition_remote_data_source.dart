import 'dart:convert';

import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/nutrition/application/models/nutiration_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_route.dart';

abstract class NutritionRemoteDataSource {
  Future<List<NutritionModel>> getAllNutrition();
}

class NutritionRemoteDataSourceImplements implements NutritionRemoteDataSource {
  final http.Client client;
  NutritionRemoteDataSourceImplements({required this.client});

  @override
  Future<List<NutritionModel>> getAllNutrition() async {
    final response = await client.get(Uri.parse('$BASE_URL/MOBILE/Nutrition'), headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson["data"];
      final List<NutritionModel> nutritionModel = data.map<NutritionModel>((jsonNutritionModel) => NutritionModel.fromJson(jsonNutritionModel)).toList();

      return nutritionModel;
    } else {
      throw ServerException();
    }
  }
}
