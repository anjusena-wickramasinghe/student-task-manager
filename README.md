# Student Task Manager

A simple Flutter mobile application to manage daily academic tasks.

## Features
- Add tasks with title, category, and priority
- View all tasks in a dashboard
- Mark tasks as completed or pending
- Delete tasks
- Input validation

## Screens
- **Home** - Dashboard with total, completed, and pending task counts
- **Add Task** - Form to add a new task with category and priority selection

## Project Structure
```
lib/
├── models/
│   └── task.dart
├── controllers/
│   └── task_controller.dart
├── views/
│   ├── home_page.dart
│   └── add_task_page.dart
└── main.dart
```

## Categories
Assignment, Lecture, Research, Exam, Personal

## Priorities
High, Medium, Low

## Getting Started
```bash
flutter pub get
flutter run
```

## Built With
- Flutter
- Dart
