import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/tasks_model.dart';

abstract class TasksRemoteDataSource {
  Future<List<TasksModel>> getAllTasks();
}

const BASE_URL = "https://agroapp.devtitechnologie.pro/api";

class TasksRemoteDataSourceImplement implements TasksRemoteDataSource {
  final http.Client client;

  TasksRemoteDataSourceImplement({
    required this.client,
  });

  @override
  Future<List<TasksModel>> getAllTasks() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/MOBILE/Tache"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = decodedJson['data'];
      final List<TasksModel> tasksModel = data.map<TasksModel>((jsonTasksModel) => TasksModel.fromJson(jsonTasksModel)).toList();
      return tasksModel;
    } else {
      throw Exception("Failed to load tasks");
    }
  }
}
