import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humap/pages/network_making/controller.dart';
import 'package:humap/services/auth_service.dart';
import 'package:humap/themes/color_theme.dart';
import 'package:humap/themes/text_theme.dart';
import 'package:lottie/lottie.dart';

import '../../routes/routes.dart';

class NetworkMakingPage extends GetWidget<NetworkMakingPageController> {
  const NetworkMakingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.makeNetwork();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset("assets/lotties/loadingFiles.json", width: Get.width * 1.1),
            const SizedBox(height: 32),
            Text(
              "${Get.find<AuthService>().user.name}님만의\n인맥이 형성되고 있어요",
              style: networkMakingPage_title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 96),
            Container(
              width: 300,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                border: Border.all(color: mainColor, width: 2),
                color: Colors.transparent
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 50),
                  width: 25 + (2.67 * controller.progressPercentage.value),
                  height: 22,
                  margin: EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        right: 4,
                        child: Icon(Icons.person, color: Colors.white, size: 16),
                      )
                    ],
                  ),
                ),)
              ),
            )
          ],
        )
      ),
    );
  }
}