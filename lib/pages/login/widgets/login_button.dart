import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/color_theme.dart';
import '../../../themes/text_theme.dart';


enum LoginButtonType {
  google,
  kakao,
  apple
}

extension LoginButtonTypeExtension on LoginButtonType {
  String get convertBtnContent {
    switch (this) {
      case LoginButtonType.google: return "구글로 로그인";
      case LoginButtonType.kakao: return "카카오톡으로 로그인";
      case LoginButtonType.apple: return "애플로 로그인";
      default: return "";
    }
  }

  Color get backgroundColor {
    switch (this) {
      case LoginButtonType.google: return Colors.white;
      case LoginButtonType.kakao: return yellowOne;
      case LoginButtonType.apple: return Colors.black;
      default: return Colors.transparent;
    }
  }

  Color get borderColor {
    switch (this) {
      case LoginButtonType.google: return grayOne;
      case LoginButtonType.kakao: return grayTwo;
      case LoginButtonType.apple: return grayOne;
      default: return Colors.transparent;
    }
  }

  Color get textColor {
    switch (this) {
      case LoginButtonType.google: return Colors.black;
      case LoginButtonType.kakao: return Colors.black;
      case LoginButtonType.apple: return Colors.white;
      default: return Colors.transparent;
    }
  }

  Widget get convertIconWidget {
    switch (this) {
      case LoginButtonType.google: return SvgPicture.asset(
        "assets/images/googleIcon.svg",
        width: 24,
      );
      case LoginButtonType.kakao: return SvgPicture.asset(
        "assets/images/kakaoIcon.svg",
        width: 24,
      );
      case LoginButtonType.apple: return SvgPicture.asset(
        "assets/images/appleIcon.svg",
        color: Colors.white,
        width: 24,
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
        width: 320,
        height: 55,
        decoration: BoxDecoration(
          color: btnType.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: btnType.borderColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Center(child: btnType.convertIconWidget), flex: 3),
            Expanded(child: Center(child: Text(btnType.convertBtnContent, style: loginBtn.copyWith(color: btnType.textColor))), flex: 4),
            Expanded(child: SizedBox(), flex: 2)
          ],
        ),
      ),
    );
  }
}