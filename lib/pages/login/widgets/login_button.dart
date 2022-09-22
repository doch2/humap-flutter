import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/color_theme.dart';
import '../../../themes/text_theme.dart';


enum LoginButtonType {
  google,
  apple
}

extension LoginButtonTypeExtension on LoginButtonType {
  String get convertBtnContent {
    switch (this) {
      case LoginButtonType.google: return "구글";
      case LoginButtonType.apple: return "애플";
      default: return "";
    }
  }

  Color get convertBackgroundColor {
    switch (this) {
      case LoginButtonType.google: return Colors.white;
      case LoginButtonType.apple: return grayTwo;
      default: return Colors.transparent;
    }
  }

  Color get convertButtonColor {
    switch (this) {
      case LoginButtonType.google: return blackOne;
      case LoginButtonType.apple: return Colors.white;
      default: return Colors.transparent;
    }
  }

  Widget get convertIconWidget {
    switch (this) {
      case LoginButtonType.google: return SvgPicture.asset(
        "assets/images/googleIcon.svg",
        width: 38,
      );
      case LoginButtonType.apple: return SvgPicture.asset(
        "assets/images/appleIcon.svg",
        width: 38,
        color: grayFour,
      );
      default: return SizedBox();
    }
  }
}

class LoginButton extends StatelessWidget {
  LoginButtonType btnType;
  dynamic clickAction;
  LoginButton({required this.btnType, required this.clickAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickAction,
      child: Container(
        width: 321,
        height: 76,
        decoration: BoxDecoration(
          color: btnType.convertBackgroundColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40C0C0C0),
              offset: Offset(0, 4),
              blurRadius: 5
            )
          ],
          border: Border.all(color: (btnType == LoginButtonType.google ? grayThree : Colors.transparent))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 22),
            btnType.convertIconWidget,
            const SizedBox(width: 64),
            Text("${btnType.convertBtnContent} 소셜 로그인")
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('테스트', textAlign: TextAlign.center),
    );
  }
}
