class CheckList {
  final int? id;
  final String? tasksName;
  final String? date;
  final String? category;
  final String? status;
  final String? type;
  final String? description;
  final int? entrepriseId;
  final int? userId;
  final String? userName;
  final String? message;

  CheckList({
    this.id,
    this.tasksName ,
    this.date , // Provide a default value if date can be null
    this.category , // Provide a default value if category can be null
    this.status , // Provide a default value if status can be null
    this.description ,
    this.entrepriseId,
    this.type,
    this.userId,
    this.userName,
    this.message
     // Provide a default value if description can be null
  });
}
