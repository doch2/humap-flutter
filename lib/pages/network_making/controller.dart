import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:humap/services/toast.dart';

import '../../routes/routes.dart';

class NetworkMakingPageController extends GetxController with StateMixin {
  RxInt progressPercentage = 0.obs;

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  makeNetwork() async {
    for (int i=0; i<100; i++) {
      await Future.delayed(Duration(milliseconds: Random().nextInt(25)+10));
      progressPercentage.value = progressPercentage.value + 1;
    }

    await Future.delayed(Duration(milliseconds: 50));
    HumapToast().showToast("인맥 생성완료!");
    Get.offAndToNamed(PageRoutes.HOME);
  }
}
