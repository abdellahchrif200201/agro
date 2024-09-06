import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';

class CheckListModel extends CheckList {
  CheckListModel({
    super.id,
     super.tasksName,
    super.date,
    super.category,
    super.status,
    super.description,
    super.entrepriseId,
    super.type,
    super.userId,
    super.userName,
    super.message
  });

  // Factory constructor to create an instance from JSON
  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(
      id: json['id'] as int?,
      // zone: json['Zone'] as String? , // Provide default value if null
      tasksName: json['TaskName'] as String? ,
      date: json['Date'] as String? ,
      category: json['status'] as String? ,
      status: json['status'] as String? ,
      type: json['Type'] as String?,
      description: json['Description'] as String? ,
      entrepriseId: json['Entreprise']['id'] as int,
      userId: json['User']['id'] as int? ,
      userName : json['User']['name'] as String?,
      message:  json['Message'] as String?
    );
  }

  // Method to convert an instance to JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'tasksName': tasksName,
  //     'entrepriseId': entrepriseId,
  //     'date': date,
  //     'type': type,
  //     'status': status,
  //     'description': description,
  //     'userId' : userId
  //   };
  // }
}
