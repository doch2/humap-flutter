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

class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "지금은 앱이 "
                  ),
                  TextSpan(
                    text: "공사중",
                    style: landingPage_title.copyWith(color: mainColor)
                  ),
                  TextSpan(
                    text: "이라 사용할 수 없어요\n나중에 다시 확인해주세요!"
                  )
                ],
              ),
              textAlign: TextAlign.center,
              style: landingPage_title,
            ),
            SizedBox(height: Get.height * 0.06),
            LottieBuilder.asset("assets/lotties/underConstruction.json", width: Get.width * 0.8)
          ],
        )
      ),
    );
  }
}