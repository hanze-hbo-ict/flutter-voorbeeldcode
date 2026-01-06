class Todo {
  int userId;
  int id;
  String title;
  bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed ? 1 : 0
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
        'completed': bool completed,
      } =>
        Todo(
          userId: userId,
          id: id,
          title: title,
          completed: completed,
        ),
      _ => throw const FormatException('Failed to load todos 😡'),
    };
  }
}
