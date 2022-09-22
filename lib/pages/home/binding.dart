import 'package:get/get.dart';

import '../../services/auth_service.dart';
import 'controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}
