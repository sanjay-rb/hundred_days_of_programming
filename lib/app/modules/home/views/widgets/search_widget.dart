import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/modules/home/controllers/home_controller.dart';
import 'package:hundred_days_of_programming/app/modules/home/views/widgets/task_search_delegate.dart';

class SearchWidget extends GetWidget<HomeController> {
  const SearchWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSearch(
          context: context,
          delegate: TaskSearchDelegate(
            controller.tasks.value,
            user,
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Material(
          color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.search),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "eg: 3 / Multipication and Division",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
