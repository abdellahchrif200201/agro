import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';

class CheckListModel extends CheckList {
  CheckListModel({
    required super.id,
    required super.tasksName,
    required super.date,
    required super.category,
    required super.status,
    required super.message,
    required super.description,
    required super.zone,
  });

  // Factory constructor to create an instance from JSON
  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(
      id: json['id'],
      zone: json['TaskName'],
      tasksName: json['TaskName'],
      date: json['Date'],
      category: json['Category'],
      status: json['Status'],
      message: json['Message'],
      description: json['Description'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Zone': zone,
      'TaskName': tasksName,
      'Date': date,
      'Category': category,
      'Status': status,
      'Message': message,
      'Description': description,
    };
  }

}
