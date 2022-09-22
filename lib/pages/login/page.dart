import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/color_theme.dart';
import 'controller.dart';
import 'widgets/login_button.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueOne,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: 265,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 120,
                    left: 32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("로그인"),
                      ],
                    ),
                  )
                ],
              )
            ),
            SizedBox(height: 100),
            LoginButton(btnType: LoginButtonType.google, clickAction: () => controller.authService.signInWithGoogle()),
          ],
        ),
      ),
    );
  }
}
