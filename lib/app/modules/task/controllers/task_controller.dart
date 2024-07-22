import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/services/logger_service.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskController extends GetxController {
  final TextEditingController github = TextEditingController();
  final TextEditingController linkedin = TextEditingController();
  final formKey = GlobalKey<FormState>();

  openGithubURL(id) async {
    final Uri url = Uri.parse(Get.find<AuthService>()
        .user
        .value
        .completedTasks!
        .where((element) => element.taskID == id)
        .first
        .githubLink!);

    if (!await launchUrl(url)) {
      LoggerService.error("Could not launch $url");
    }
  }

  openLinkedInURL(id) async {
    final Uri url = Uri.parse(Get.find<AuthService>()
        .user
        .value
        .completedTasks!
        .where((element) => element.taskID == id)
        .first
        .linkedinLink!);

    if (!await launchUrl(url)) {
      LoggerService.error("Could not launch $url");
    }
  }

  String? validateURLFields(String value, String field) {
    if (value.isEmpty) {
      return "Please complete the field before submitting.";
    }
    if (field == 'github') {
      String? profileGithub = Get.find<AuthService>().user.value.github;
      if (profileGithub == null || profileGithub == "") {
        return "Please update your profile before submitting the task.";
      }
      if (!value.startsWith(profileGithub)) {
        return "Please provide a valid URL from your account.";
      }
    }
    if (field == 'linkedin') {
      String? profileLinkedin = Get.find<AuthService>().user.value.linkedin;
      if (profileLinkedin == null || profileLinkedin == "") {
        return "Please update your profile before submitting the task.";
      }
      String profileName = profileLinkedin.split('/').last;
      String linkedInPostUrlPrefix =
          "https://www.linkedin.com/posts/$profileName";
      if (!value.startsWith(linkedInPostUrlPrefix)) {
        return "Please provide a valid URL from your account.";
      }
    }
    return null;
  }

  bool canComplete() {
    UserModel user = Get.find<AuthService>().user.value;
    int dateDiff = Timestamp.now()
        .toDate()
        .difference(user.lastSubmittedDate!.toDate())
        .inDays;
    if (dateDiff == 0) {
      LoggerService.info(
        "I appreciate your enthusiasm, but you can only submit one task per day. Relax and enjoy a chai; we'll tackle the next task after ${DateFormat.yMMMMd().add_jms().format(user.lastSubmittedDate!.toDate())}.",
      );
      return false;
    }
    return true;
  }

  Future<void> markAsComplete(String taskId) async {
    Get.focusScope?.unfocus();
    if (formKey.currentState!.validate()) {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: Get.theme.colorScheme.secondary,
          ),
        ),
        barrierDismissible: false,
      );

      try {
        UserModel user = Get.find<AuthService>().user.value;
        user.lastSubmittedDate = Timestamp.now();
        user.completedTasks!.add(
          CompletedTasks(
            taskID: taskId,
            githubLink: github.text,
            linkedinLink: linkedin.text,
            submittedDate: Timestamp.now(),
          ),
        );
        await user.updateUser();
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.back(closeOverlays: true);
        LoggerService.error(e.toString());
      }
    }
  }
}
