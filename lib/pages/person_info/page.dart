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

class PersonInfoPage extends StatelessWidget {
  const PersonInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<AppFirstRun>().isAppFirstRun = false;

    return Scaffold(
      body: Center(
        child: ExtendedImage.asset("assets/images/personInfo.png")
      ),
    );
  }
}