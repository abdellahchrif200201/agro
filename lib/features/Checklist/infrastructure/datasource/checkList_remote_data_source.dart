import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/Checklist/application/models/check_list_model.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_route.dart';

abstract class ChecklistRemoteDataSource {
  Future<List<CheckList>> getAllCheckList();
  Future<Unit> deleteTache(int tachID);
  Future<Unit> updateTache(CheckListModel checkListModel);
  Future<Unit> addTache(CheckListModel checkListModel);
}

class ChecklistRemoteDataSourceImplement implements ChecklistRemoteDataSource {
  final http.Client client;
  ChecklistRemoteDataSourceImplement({required this.client});

  @override
  Future<List<CheckList>> getAllCheckList() async {
    final response = await client.get(Uri.parse('$BASE_URL/WEB/Tache'), headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson["data"];
      final List<CheckList> checkList = data.map<CheckList>((jsonCheckListModel) => CheckListModel.fromJson(jsonCheckListModel)).toList();

      return checkList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteTache(int tacheId) async {
    final response = await client.delete(
      Uri.parse("$BASE_URL/WEB/Tache/${tacheId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print(response.body);
      return Future.value(unit);
    } else {
      print(response.body);
      throw ServerException();
    }
  }

  @override
  Future<Unit> addTache(CheckListModel checkListModel) async {
    final body = {
      "Name": checkListModel.tasksName,
      "EntrepriseId": checkListModel.entrepriseId,
      "Date": checkListModel.date,
      "Type": checkListModel.type,
      "Status": checkListModel.status,
      "Description": checkListModel.description,
      "UserId": checkListModel.userId
    };

    final response = await client.post(
      Uri.parse("$BASE_URL/WEB/Tache"),
      headers: {"Content-Type": "application/json"}, // Set the content type to JSON
      body: jsonEncode(body), // Encode the body as JSON
    );

    if (response.statusCode == 201) {
      print(response.body);
      return Future.value(unit);
    } else {
      print(response.body);
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateTache(CheckListModel checkListModel) async {
    final tacheId = checkListModel.id.toString();
    print("iddddddddddddddddd $tacheId");

    final taskName = checkListModel.tasksName;

    print("iddddddddddddddddd $taskName");

    if (tacheId.isEmpty) {
      print('Invalid task ID: $tacheId');
      throw Exception('Task ID is null or empty');
    }
    final body = {
      "Name": checkListModel.tasksName,
      "Date": checkListModel.date,
      "Type": checkListModel.type,
      // "Category": checkListModel.category,
      "Status": checkListModel.status,
      // "Message": checkListModel.message,
      "Description": checkListModel.description,
      // "ZoneId": checkListModel.id,
      "UserId": checkListModel.userId
    };

    final response = await client.put(
      Uri.parse("$BASE_URL/WEB/Tache/$tacheId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return Future.value(unit);
    } else {
      print(response.body);

      throw ServerException();
    }
  }
}
