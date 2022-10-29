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

extension PurpleButtonStatusTypeExtension on PurpleButtonStatusType {
  Color get color {
    switch (this) {
      case PurpleButtonStatusType.enable: return mainColor;
      case PurpleButtonStatusType.disable: return grayFour;
      default: return Colors.transparent;
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
          color: btnStatusType.color,
          borderRadius: BorderRadius.circular(btnSizeType.borderRadius),
        ),
        child: Center(
          child: Text(btnText, style: purpleBtn.copyWith(fontSize: btnSizeType.textSize)),
        )
      ),
    );
  }
}