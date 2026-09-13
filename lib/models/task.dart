class Task {
  final String title;
  final String category;
  final String priority;
  bool completed;

  Task({
    required this.title,
    required this.category,
    required this.priority,
    this.completed = false,
  });
}
