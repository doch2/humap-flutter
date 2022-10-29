import 'package:card_swiper/card_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humap/common_widgets/purple_button.dart';
import 'package:humap/services/app_first_run.dart';
import 'package:humap/services/auth_service.dart';
import 'package:humap/themes/color_theme.dart';
import 'package:humap/themes/text_theme.dart';
import 'package:lottie/lottie.dart';

import '../../routes/routes.dart';

class ContactInfoConnectAgreePage extends StatelessWidget {
  const ContactInfoConnectAgreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset("assets/lotties/networkingForAll.json", width: Get.width * 0.525),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "연락처를 연결",
                          style: contactInfoConnectAgreePage_title.copyWith(color: mainColor)
                      ),
                      TextSpan(
                          text: "하면\n더 쉽게 인맥 관리를 할 수 있어요"
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                  style: contactInfoConnectAgreePage_title,
                ),
                const SizedBox(height: 32),
                Text(
                  "여기저기 흩어져 있는 유도희님의 인간관계를\n인공지능 기술을 활용하여 HuMap에 모아,\n쉽게 인맥을 확인할 수 있게 할거에요.\n\n이러한 작업을 거쳐 ${Get.find<AuthService>().user.name}님이 보기 편하게\n만들어진 인간관계 네트워크를 만나보세요.",
                  style: contactInfoConnectAgreePage_description,
                )
              ],
            ),
            const SizedBox(height: 96),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PurpleButton(
                  btnSizeType: PurpleButtonSizeType.small,
                  btnStatusType: PurpleButtonStatusType.disable,
                  btnText: "다음에",
                  clickAction: () => Get.offAndToNamed(PageRoutes.HOME),
                ),
                const SizedBox(width: 8),
                PurpleButton(
                  btnSizeType: PurpleButtonSizeType.small,
                  btnStatusType: PurpleButtonStatusType.enable,
                  btnText: "사용하기",
                  clickAction: () => Get.offAndToNamed(PageRoutes.HOME),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}