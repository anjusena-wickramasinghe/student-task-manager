import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'add_task_page.dart';
import 'task_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _controller = TaskController();

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'High': return Colors.red;
      case 'Medium': return Colors.orange;
      default: return Colors.green;
    }
  }

  Future<void> _goToAddTask() async {
    final task = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskPage()),
    );
    if (task != null) setState(() => _controller.addTask(task));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Student Task Manager', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF3F51B5),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Dashboard Card
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3F51B5), Color(0xFF7986CB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _stat('Total', _controller.totalTasks, Colors.white),
                  _divider(),
                  _stat('Completed', _controller.completedTasks, const Color(0xFF80FF80)),
                  _divider(),
                  _stat('Pending', _controller.pendingTasks, const Color(0xFFFFD54F)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Add Task Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _goToAddTask,
                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                label: const Text('Add New Task', style: TextStyle(fontSize: 16, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F51B5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Task List', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3F51B5))),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _controller.tasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.assignment_outlined, size: 64, color: Colors.grey),
                          SizedBox(height: 12),
                          Text('No tasks yet. Add one!', style: TextStyle(color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _controller.tasks.length,
                      itemBuilder: (_, i) {
                        final task = _controller.tasks[i];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailPage(
                                task: task,
                                onComplete: () => setState(() => _controller.changeStatus(i)),
                                onDelete: () => setState(() => _controller.deleteTask(i)),
                              ),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border(
                                left: BorderSide(color: _priorityColor(task.priority), width: 5),
                              ),
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(task.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: task.completed ? Colors.green.shade100 : Colors.orange.shade100,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          task.completed ? 'Completed' : 'Pending',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: task.completed ? Colors.green.shade700 : Colors.orange.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.category_outlined, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(task.category, style: const TextStyle(color: Colors.grey)),
                                      const SizedBox(width: 12),
                                      Icon(Icons.flag_outlined, size: 14, color: _priorityColor(task.priority)),
                                      const SizedBox(width: 4),
                                      Text(task.priority, style: TextStyle(color: _priorityColor(task.priority), fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => setState(() => _controller.changeStatus(i)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: task.completed ? Colors.orange : Colors.green,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          minimumSize: Size.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Text(task.completed ? 'Mark Pending' : 'Complete', style: const TextStyle(fontSize: 12)),
                                      ),
                                      const SizedBox(width: 8),
                                      OutlinedButton(
                                        onPressed: () => setState(() => _controller.deleteTask(i)),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.red,
                                          side: const BorderSide(color: Colors.red),
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          minimumSize: Size.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: const Text('Delete', style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, int count, Color color) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(color: color.withOpacity(0.85), fontSize: 13)),
      ],
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 40, color: Colors.white30);
  }
}
