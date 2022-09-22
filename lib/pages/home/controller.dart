import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController with StateMixin {

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
