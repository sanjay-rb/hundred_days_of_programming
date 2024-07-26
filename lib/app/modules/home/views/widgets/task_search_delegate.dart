import 'package:flutter/material.dart';
import 'package:hundred_days_of_programming/app/data/models/task_model.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_list_tile_widget.dart';

class TaskSearchDelegate extends SearchDelegate<TaskModel> {
  TaskSearchDelegate(this.tasks, this.user);
  final List<TaskModel> tasks;
  final UserModel user;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          textTheme: TextTheme(
            titleLarge: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, TaskModel());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<TaskModel> filterTasks = tasks
        .where(
          (task) => (task.title!.toLowerCase().contains(query.toLowerCase()) ||
              task.id!.toLowerCase().contains(query.toLowerCase())),
        )
        .toList();
    return ListView.builder(
      itemCount: filterTasks.length,
      itemBuilder: (context, index) {
        return UiListTileWidget(task: filterTasks[index], user: user);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<TaskModel> filterTasks = tasks
        .where(
          (task) => (task.title!.toLowerCase().contains(query.toLowerCase()) ||
              task.id!.toLowerCase().contains(query.toLowerCase())),
        )
        .toList();
    return ListView.builder(
      itemCount: filterTasks.length,
      itemBuilder: (context, index) {
        return UiListTileWidget(task: filterTasks[index], user: user);
      },
    );
  }
}
