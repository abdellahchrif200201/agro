import 'dart:convert';

import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/Tracbalite/application/models/tracabilite_model.dart';
import 'package:http/http.dart' as http;

abstract class TracabiliteRemoteDataSource{
  Future<List<TracabiliteModel>> getAllTracabilite();
}

const BASE_URL = "https://agroapp.devtitechnologie.pro/api/MOBILE/NutritionTracability";

class TracabiliteRemoteDataSourceImplements implements TracabiliteRemoteDataSource{
  final http.Client client;
  TracabiliteRemoteDataSourceImplements({
    required this.client
  });

  @override
  Future<List<TracabiliteModel>> getAllTracabilite() async {
    final response = await client.get(
      Uri.parse(BASE_URL), headers: {
        "Content-type" : "application/json"
    }
    );

    if(response.statusCode == 200){
      final Map<String , dynamic> decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson["data"];
      final List<TracabiliteModel> tracabiliteModel = data.map<TracabiliteModel>(
          (jsonTracabiliteModel) => TracabiliteModel.fromJson(jsonTracabiliteModel)
      ).toList();

      return tracabiliteModel;
    }
    else{
      throw ServerException();
    }
  }
}