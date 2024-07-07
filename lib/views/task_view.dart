import 'package:flutter/material.dart';
import 'package:hundred_days_of_programming/models/task_model.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Text(task.id),
      ),
    );
  }
}
