import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humap/services/app_first_run.dart';

import '../routes/routes.dart';

class LandingMiddleware extends GetMiddleware {
  final AppFirstRun appFirstRun = Get.find<AppFirstRun>();

  LandingMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    Future.delayed(Duration(milliseconds: 100));

    return appFirstRun.isAppFirstRun ? RouteSettings(name: PageRoutes.LANDING, arguments: {'redirect': route}) : null;
  }
}
