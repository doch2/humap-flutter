import 'package:card_swiper/card_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humap/common_widgets/purple_button.dart';
import 'package:humap/services/app_first_run.dart';
import 'package:humap/themes/color_theme.dart';
import 'package:humap/themes/text_theme.dart';
import 'package:lottie/lottie.dart';

import '../../routes/routes.dart';

class PrivacyPolicyAgreePage extends StatelessWidget {
  const PrivacyPolicyAgreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset("assets/lotties/earthLocationAnimation.json", width: Get.width * 0.525),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "HuMap을 사용하시려면,\n"
                      ),
                      TextSpan(
                          text: "개인 정보와 위치 정보 활용 동의",
                          style: privacyPolicyAgreePage_title.copyWith(color: mainColor)
                      ),
                      TextSpan(
                          text: "가\n필요해요"
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                  style: privacyPolicyAgreePage_title,
                ),
                const SizedBox(height: 32),
                Text(
                  "인맥 네트워크를 형성하는 과정에서\n여러분의 정보가 사용돼요.\n\n동의하지 않는다면 HuMap의\n유용한 기능들을 사용할 수 없어요.",
                  style: privacyPolicyAgreePage_description,
                )
              ],
            ),
            const SizedBox(height: 96),
            PurpleButton(
              btnSizeType: PurpleButtonSizeType.small,
              btnStatusType: PurpleButtonStatusType.enable,
              btnText: "동의",
              clickAction: () => Get.offAndToNamed(PageRoutes.CONTACTINFOCONNECTAGREE),
            )
          ],
        )
      ),
    );
  }
}