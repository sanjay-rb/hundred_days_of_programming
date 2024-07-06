// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:hundred_days_of_programming/views/home_view.dart';
import 'package:hundred_days_of_programming/views/login_view.dart';
import 'package:hundred_days_of_programming/views/profile_view.dart';
import 'package:hundred_days_of_programming/views/task_view.dart';

class GetRoute {
  static const init = '/login';
  static final route = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/home', page: () => HomeView()),
    GetPage(name: '/profile', page: () => ProfileView()),
    GetPage(name: '/task', page: () => TaskView(task: Get.arguments)),
  ];
}
