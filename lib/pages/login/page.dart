import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:humap/themes/text_theme.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/logo.svg"),
            const SizedBox(height: 64),
            Text("HuMap", style: loginPage_title),
            const SizedBox(height: 6),
            const Text("소중한 인맥을 한 눈에 담다", style: loginPage_description),
            const SizedBox(height: 64),
            Stack(
              alignment: Alignment.center,
              children: [
                Text("간편로그인", style: loginPage_simpleLogin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 118, child: Divider(color: grayThree, thickness: 1.0)),
                    SizedBox(width: 84),
                    Container(width: 118, child: Divider(color: grayThree, thickness: 1.0))
                  ],
                )
              ],
            ),
            const SizedBox(height: 32),
            LoginButton(btnType: LoginButtonType.google, clickAction: () => controller.authService.signInWithGoogle()),
            const SizedBox(height: 16),
            LoginButton(btnType: LoginButtonType.kakao, clickAction: () => controller.authService.signInWithKakao()),
          ],
        ),
      ),
    );
  }
}
