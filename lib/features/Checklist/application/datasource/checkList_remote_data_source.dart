import 'dart:convert';

import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/Checklist/application/models/check_list_model.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:http/http.dart' as http;

abstract class ChecklistRemoteDataSource {
  Future<List<CheckList>> getAllCheckList();
}

const BASE_URL = "https://agroapp.devtitechnologie.pro/api/MOBILE/Tache";

class ChecklistRemoteDataSourceImplement implements ChecklistRemoteDataSource {
  final http.Client client;
  ChecklistRemoteDataSourceImplement({required this.client});

  @override
  Future<List<CheckList>> getAllCheckList() async {
    final response = await client.get(Uri.parse(BASE_URL), headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson["data"];
      final List<CheckList> checkList = data.map<CheckList>((jsonCheckListModel) => CheckListModel.fromJson(jsonCheckListModel)).toList();

      return checkList;
    } else {
      throw ServerException();
    }
  }
}
