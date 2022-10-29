import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/color_theme.dart';
import '../../../themes/text_theme.dart';


enum PurpleButtonSizeType {
  small,
  big,
}

enum PurpleButtonStatusType {
  enable,
  disable
}

extension PurpleButtonSizeTypeExtension on PurpleButtonSizeType {
  double get width {
    switch (this) {
      case PurpleButtonSizeType.big: return 320;
      case PurpleButtonSizeType.small: return 160;
      default: return 0;
    }
  }

   double get height {
    switch (this) {
      case PurpleButtonSizeType.big: return 55;
      case PurpleButtonSizeType.small: return 50;
      default: return 0;
    }
  }

  double get borderRadius {
    switch (this) {
      case PurpleButtonSizeType.big: return 10;
      case PurpleButtonSizeType.small: return 8;
      default: return 0;
    }
  }

  double get textSize {
    switch (this) {
      case PurpleButtonSizeType.big: return 17;
      case PurpleButtonSizeType.small: return 16;
      default: return 0;
    }
  }
}

class PurpleButton extends StatelessWidget {
  PurpleButtonSizeType btnSizeType;
  PurpleButtonStatusType btnStatusType;
  String btnText;
  dynamic clickAction;
  PurpleButton({required this.btnSizeType, required this.btnStatusType, required this.btnText, required this.clickAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickAction,
      child: Container(
        width: btnSizeType.width,
        height: btnSizeType.height,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(btnSizeType.borderRadius),
        ),
        child: Center(
          child: Text(btnText, style: purpleBtn.copyWith(fontSize: btnSizeType.textSize)),
        )
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
