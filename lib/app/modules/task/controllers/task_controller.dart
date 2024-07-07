import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/services/logger_service.dart';

class TaskController extends GetxController {
  Future<bool> markAsComplete(
    String taskId,
    String github,
    String linkedin,
  ) async {
    UserModel user = Get.find<AuthService>().user.value;
    user.github = github;
    user.linkedin = linkedin;
    int dateDiff = Timestamp.now()
        .toDate()
        .difference(user.lastSubmittedDate!.toDate())
        .inDays;
    if (dateDiff == 0) {
      LoggerService.info(
        "I appreciate your enthusiasm, but you can only submit one task per day. Relax and enjoy a chai; we'll tackle the next task tomorrow.",
      );
      return false;
    }
    user.lastSubmittedDate = Timestamp.now();
    user.completedTasks!.add(CompletedTasks(
        taskID: taskId,
        githubLink: github,
        linkedinLink: linkedin,
        submittedDate: Timestamp.now()));
    try {
      await user.updateUser();
      return true;
    } catch (e) {
      LoggerService.error(e.toString());
    }
    return false;
  }
}
