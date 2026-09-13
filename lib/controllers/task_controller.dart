import '../models/task.dart';

class TaskController {
  final List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }

  void changeStatus(int index) {
    tasks[index].completed = !tasks[index].completed;
  }

  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((t) => t.completed).length;
  int get pendingTasks => tasks.where((t) => !t.completed).length;
}
