class CheckList {
  final int id;
  final String? tasksName;
  final String? zone;
  final String? date;
  final String? category;
  final String? status;
  final String? message;
  final String? description;

  CheckList({
    required this.id,
     this.tasksName = "tasksName",
    this.zone = 'zone', // Provide a default value if zone can be null
    this.date = '2022-06-52 00:00:00', // Provide a default value if date can be null
    this.category = 'category', // Provide a default value if category can be null
    this.status = 'status', // Provide a default value if status can be null
    this.message = 'message', // Provide a default value if message can be null
    this.description = 'description', // Provide a default value if description can be null
  });
}
