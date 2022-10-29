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

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<AppFirstRun>().isAppFirstRun = false;

    return Scaffold(
      body: Center(
        child: Swiper(
          itemBuilder: (BuildContext context, int index){
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(width: Get.width, height: Get.height),
                Positioned(
                  top: Get.height * 0.2,
                  child: pageTextWidget(index+1),
                ),
                Positioned(
                  top: Get.height * 0.3,
                  child: SizedBox(
                    height: Get.height * 0.5,
                    child: Center(child: pageContentWidget(index+1)),
                  ),
                ),
                Positioned(
                  bottom: (index!=3 ? -500 : 46),
                  child: PurpleButton(
                    btnSizeType: PurpleButtonSizeType.big,
                    btnStatusType: PurpleButtonStatusType.enable,
                    btnText: "시작하기",
                    clickAction: () => Get.offAndToNamed(PageRoutes.LOGIN),
                  )
                )
              ],
            );
          },
          loop: false,
          itemCount: 4,
          pagination: SwiperPagination(
              margin: EdgeInsets.only(bottom: Get.height * 0.17),
              builder: SwiperCustomPagination(builder: (context, config) {
                return SizedBox(
                  width: 70,
                  height: 10,
                  child: ListView.builder(
                    itemCount: config.itemCount,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ConstrainedBox(
                      constraints: BoxConstraints.expand(width: 18),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (config.activeIndex == index) ? mainColor : Colors.white,
                            border: Border.all(color: ((config.activeIndex != index) ? mainColor : Colors.transparent), width: 1)
                        ),
                        margin: const EdgeInsets.only(right: 7.5),
                      ),
                    ),
                  ),
                );
              })
          ),
        ),
      ),
    );
  }

  pageTextWidget(int index) {
    switch (index) {
      case 1: return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "소중한 인맥을 한 눈에 담으러 오신\n",
              style: landingPage_title.copyWith(color: mainColor)
            ),
            TextSpan(
                text: "여러분 환영합니다👋"
            )
          ],
        ),
        textAlign: TextAlign.center,
        style: landingPage_title,
      );
      case 2: return Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: "여러분의 인맥을\n"
            ),
            TextSpan(
                text: "자유롭게 정리",
                style: landingPage_title.copyWith(color: mainColor)
            ),
            TextSpan(
                text: "해보세요"
            )
          ],
        ),
        textAlign: TextAlign.center,
        style: landingPage_title,
      );
      case 3: return Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: "이젠 개개인의 추억도\n"
            ),
            TextSpan(
                text: "다이어리에 보관",
                style: landingPage_title.copyWith(color: mainColor)
            ),
            TextSpan(
                text: "해 봐요"
            )
          ],
        ),
        textAlign: TextAlign.center,
        style: landingPage_title,
      );
      case 4: return Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: "지인에게 "
            ),
            TextSpan(
                text: "검증된 사람",
                style: landingPage_title.copyWith(color: mainColor)
            ),
            TextSpan(
                text: "을 통해\n"
            ),
            TextSpan(
                text: "안전하고 친근한 인맥",
                style: landingPage_title.copyWith(color: mainColor)
            ),
            TextSpan(
                text: "을 만들어 갈 수 있어요"
            )
          ],
        ),
        textAlign: TextAlign.center,
        style: landingPage_title,
      );

    }
  }

  pageContentWidget(int index) {
    switch (index) {
      case 1: return LottieBuilder.asset("assets/lotties/welcome.json", width: Get.width * 0.8);
      case 2: return ExtendedImage.asset("assets/images/networkMockup.png", width: Get.width * 0.53);
      case 3: return ExtendedImage.asset("assets/images/diaryMockup.png", width: Get.width * 0.53);
      case 4: return LottieBuilder.asset("assets/lotties/connectingPeople.json", width: Get.width * 0.95);
    }
  }
}