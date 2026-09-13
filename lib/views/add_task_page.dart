import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  String _category = 'Assignment';
  String _priority = 'Medium';

  final List<String> _categories = ['Assignment', 'Lecture', 'Research', 'Exam', 'Personal'];
  final List<String> _priorities = ['High', 'Medium', 'Low'];

  final Map<String, IconData> _categoryIcons = {
    'Assignment': Icons.assignment,
    'Lecture': Icons.school,
    'Research': Icons.science,
    'Exam': Icons.quiz,
    'Personal': Icons.person,
  };

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Task(title: _titleController.text.trim(), category: _category, priority: _priority),
      );
    }
  }

  Color _priorityColor(String p) {
    switch (p) {
      case 'High': return Colors.red;
      case 'Medium': return Colors.orange;
      default: return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Add New Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF3F51B5),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Task Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3F51B5))),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Name',
                  prefixIcon: const Icon(Icons.edit_note, color: Color(0xFF3F51B5)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF3F51B5), width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Task name cannot be empty' : null,
              ),
              const SizedBox(height: 16),
              // Category selector
              const Text('Category', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((c) {
                  final selected = _category == c;
                  return GestureDetector(
                    onTap: () => setState(() => _category = c),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? const Color(0xFF3F51B5) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF3F51B5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_categoryIcons[c], size: 16, color: selected ? Colors.white : const Color(0xFF3F51B5)),
                          const SizedBox(width: 6),
                          Text(c, style: TextStyle(color: selected ? Colors.white : const Color(0xFF3F51B5), fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Priority selector
              const Text('Priority', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 8),
              Row(
                children: _priorities.map((p) {
                  final selected = _priority == p;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _priority = p),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selected ? _priorityColor(p) : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _priorityColor(p)),
                        ),
                        child: Center(
                          child: Text(
                            p,
                            style: TextStyle(
                              color: selected ? Colors.white : _priorityColor(p),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F51B5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Add Task', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
