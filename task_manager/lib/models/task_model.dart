class TaskModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  final String? description;
  final DateTime? deadline;

  TaskModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
    this.description,
    this.deadline,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  TaskModel copyWith({bool? completed}) {
    return TaskModel(
      userId: userId,
      id: id,
      title: title,
      completed: completed ?? this.completed,
      description: description,
      deadline: deadline,
    );
  }

  String get statusText => completed ? 'Completed' : 'Pending';
}
