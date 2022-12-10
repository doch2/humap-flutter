import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humap/services/remote_config.dart';

import '../routes/routes.dart';
import '../services/auth_service.dart';

class UnderConstructionMiddleware extends GetMiddleware {
  final RemoteConfigService remoteConfigService = Get.find<RemoteConfigService>();

  UnderConstructionMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    return remoteConfigService.getIsAppOpen() ? null : RouteSettings(name: PageRoutes.UNDERCONSTRUCTION, arguments: {'redirect': route});
  }
}
