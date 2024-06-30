// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:hundred_days_of_programming/views/home_view/home_view.dart';

class GetRoute {
  static const init = '/home';
  static final route = [
    GetPage(name: '/home', page: () => const HomeView()),
  ];
}
