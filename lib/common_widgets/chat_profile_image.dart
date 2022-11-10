import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

import '../../../themes/color_theme.dart';



enum ChatProfileImageSizeType {
  small,
  big,
}


class ChatProfileImage extends StatelessWidget {
  ChatProfileImageSizeType sizeType;
  String profileImgURL;
  ChatProfileImage({required this.sizeType, required this.profileImgURL});

  @override
  Widget build(BuildContext context) {
    return HexagonWidget.pointy(
      width: (sizeType == ChatProfileImageSizeType.big ? 53 : 38),
      color: mainColor,
      child: HexagonWidget.pointy(
        width: (sizeType == ChatProfileImageSizeType.big ? 45 : 33),
        color: mainColor,
        child: ExtendedImage.network(
          profileImgURL,
        ),
      ),
    );
  }
}