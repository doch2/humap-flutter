import 'package:get/get.dart';

import 'controller.dart';

class NetworkMakingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkMakingPageController>(() => NetworkMakingPageController());
  }
}
