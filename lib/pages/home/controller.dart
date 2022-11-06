import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:humap/services/toast.dart';

class HomePageController extends GetxController with StateMixin {
  HumapToast humapToast = HumapToast();

  RxBool isMapOpen = false.obs;
  RxBool isMoreOptionOpen = false.obs;

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
