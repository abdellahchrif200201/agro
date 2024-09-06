import 'package:devti_agro/features/overview/domain/entities/task.dart';

class TasksModel extends Tasks {
  TasksModel({
    required super.id,
    required super.taskName,
    required super.status,
    required super.description,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) {
    return TasksModel(
      id: json['id'] as int,
      taskName: json['TaskName'] as String,
      status: json['status'] as String,
      description: json['Description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'TaskName': taskName,
      'status': status,
      'Description': description,
    };
  }
}
