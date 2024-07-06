import 'package:flutter/material.dart';
import 'package:hundred_days_of_programming/models/task_model.dart';
import 'package:hundred_days_of_programming/models/user_model.dart';

class UiListTileWidget extends StatelessWidget {
  const UiListTileWidget({
    super.key,
    required this.task,
    required this.user,
    required this.index,
    required this.event,
  });

  final TaskModel task;
  final UserModel user;
  final int index;
  final Function event;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.navigate_next,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          event();
          return false; // Prevent dismissing for the update action
        }
        return true;
      },
      key: ValueKey(task.id),
      child: ListTile(
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.completedTasks.contains(task.id) ? '🟢' : '🔴',
            ),
          ],
        ),
        title: Text(
          'Day ${task.day}',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        subtitle: Text(
          task.title,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        isThreeLine: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              index <= user.completedTasks.length
                  ? Icons.lock_open_rounded
                  : Icons.lock_outline,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ],
        ),
        onTap: () {
          event();
        },
      ),
    );
  }
}
