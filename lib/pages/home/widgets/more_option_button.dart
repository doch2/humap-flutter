import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/color_theme.dart';
import '../../../themes/text_theme.dart';


enum MoreOptionButtonType {
  chat,
  search,
  post,
}

extension MoreOptionButtonTypeExtension on MoreOptionButtonType {
  Widget get iconWidget {
    switch (this) {
      case MoreOptionButtonType.chat: return SvgPicture.asset(
        "assets/images/icons/chatBubble.svg",
        width: 24,
      );
      case MoreOptionButtonType.search: return SvgPicture.asset(
        "assets/images/icons/search.svg",
        width: 24,
      );
      case MoreOptionButtonType.post: return SvgPicture.asset(
        "assets/images/icons/post.svg",
        width: 24,
      );
      default: return SizedBox();
    }
  }
}

class MoreOptionButton extends StatelessWidget {
  MoreOptionButtonType btnType;
  dynamic clickAction;
  MoreOptionButton({required this.btnType, required this.clickAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickAction,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(child: btnType.iconWidget)
      ),
    );
  }
}