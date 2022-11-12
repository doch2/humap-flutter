import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:humap/services/toast.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageController extends GetxController with StateMixin {
  HumapToast humapToast = HumapToast();

  RxBool isMapOpen = false.obs;
  RxBool isMoreOptionOpen = false.obs;

  RxString profileImgURL = "".obs;
  RxString personName = "".obs;
  RxString personCategory = "".obs;
  RxBool isPersonInfoShow = false.obs;

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();

    Permission.locationWhenInUse.request();
  }
}
