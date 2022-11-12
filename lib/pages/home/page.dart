import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:humap/common_widgets/chat_profile_image.dart';
import 'package:humap/pages/home/widgets/more_option_button.dart';
import 'package:humap/services/auth_service.dart';
import 'package:network_graph/network_graph.dart';

import '../../routes/routes.dart';
import '../../themes/color_theme.dart' as HuMapColor;
import '../../themes/color_theme.dart';
import '../../themes/text_theme.dart';
import 'controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration animatedDuration = const Duration(milliseconds: 300);
    Duration optionAnimatedDuration = const Duration(milliseconds: 200);

    List<Marker> markerList = [];
    OverlayImage.fromAssetImage(
      assetName: 'assets/images/hexagonInMap.png',
    ).then((image) {
      markerList.add(Marker(
        markerId: 'id1',
        position: LatLng(36.335800, 127.452833),
        captionText: "유도희",
        captionColor: Colors.indigo,
        captionTextSize: 20.0,
        captionOffset: -60,
        icon: image,
        anchor: AnchorPoint(0.5, 1),
        width: 85,
        height: 85,
        infoWindow: '유도희',));

      markerList.add(Marker(
        markerId: 'id2',
        position: LatLng(36.335800, 127.448833),
        captionText: "라윤지",
        captionColor: Colors.indigo,
        captionTextSize: 20.0,
        captionOffset: -60,
        icon: image,
        anchor: AnchorPoint(0.5, 1),
        width: 85,
        height: 85,
        infoWindow: '라윤지',));
    });

    OverlayImage.fromAssetImage(
      assetName: 'assets/images/hexagonInMapBlue.png',
    ).then((image) {
      markerList.add(Marker(
        markerId: 'id3',
        position: LatLng(36.334200, 127.448833),
        captionText: "오명훈",
        captionColor: Colors.indigo,
        captionTextSize: 20.0,
        captionOffset: -60,
        icon: image,
        anchor: AnchorPoint(0.5, 1),
        width: 85,
        height: 85,
        infoWindow: '오명훈',));
    });


    
    return Scaffold(
      backgroundColor: HuMapColor.blueOne,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(width: Get.width, height: Get.height),
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: MultiNetworkGraphView(
                isShowArrowShape: false,
                nodeGroupList: [
                  NodeGroup(
                      title: "디미고",
                      centerNodeOnClick: () => controller.humapToast.showToast("디미고 Center Node onClick"),
                      gradient: purpleLinearGradientOne,
                      childNodeList: [
                        NodeModel(
                          onClick: () {
                            controller.personCategory.value = "디자이너";
                            controller.personName.value = "라윤지";
                            controller.profileImgURL.value = "https://user-images.githubusercontent.com/30923566/201456081-6dd066f5-bd34-4150-ac1e-d8bd55c14de4.png";
                            controller.isPersonInfoShow.value = true;
                          },
                            content: "라윤지"
                        ),
                        NodeModel(onClick: () => controller.isPersonInfoShow.value = false, content: "유도희"),
                        NodeModel(onClick: () => controller.isPersonInfoShow.value = false, content: "오명훈"),
                        NodeModel(onClick: () => controller.isPersonInfoShow.value = false, content: "이은수"),
                        NodeModel(onClick: () => controller.isPersonInfoShow.value = false, content: "김민성"),
                      ],
                      x: (Get.width / 2),
                      y: (Get.height / 1.6)
                  ),
                  NodeGroup(
                      title: "대회",
                      centerNodeOnClick: () => controller.humapToast.showToast("대회 Center Node onClick"),
                      gradient: blueLinearGradientOne,
                      childNodeList: [
                        NodeModel(onClick: () => controller.isPersonInfoShow.value = false, content: "SW경진대회 멘토님"),
                        NodeModel(onClick: () => controller.isPersonInfoShow.value = false, content: "지도선생님"),
                        NodeModel(onClick: () => controller.isPersonInfoShow.value = false, content: "운영처"),
                        NodeModel(onClick: () => controller.isPersonInfoShow.value = false, content: "운영팀장님"),
                      ],
                      x: (Get.width / 1.85),
                      y: (Get.height / 4.5)
                  )
                ],
              ),
            ),
            const Positioned(
              top: 16,
              child: Text("학교"),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width,
                height: 148,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 36,
                      height: 3,
                      decoration: BoxDecoration(
                          color: HuMapColor.grayFive,
                          borderRadius: BorderRadius.circular(1.5)
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(() => (
                        controller.isPersonInfoShow.value ?
                        Row(
                          children: [
                            Expanded(flex: 3, child: ChatProfileImage(sizeType: ChatProfileImageSizeType.big, profileImgURL: controller.profileImgURL.value)),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${controller.personName.value}", style: homePage_personName),
                                  const SizedBox(height: 6),
                                  Text("${controller.personCategory.value}", style: homePage_category),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.toNamed(PageRoutes.PERSONINFO),
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset("assets/images/icons/people.svg"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ) : SizedBox()
                    ))
                  ],
                ),
              ),
            ),
            Obx(() => AnimatedPositioned(
              top: 0,
              left: controller.isMapOpen.value ? 0 : Get.width,
              duration: animatedDuration,
              curve: Curves.easeIn,
              child: Container(
                width: Get.width,
                height: Get.height - 150,
                child: NaverMap(
                  useSurface: kReleaseMode,
                  locationButtonEnable: true,
                  markers: markerList,
                ),
              ),
            )),
            Obx(() => AnimatedPositioned(
              bottom: 0,
              left: controller.isMapOpen.value ? 0 : Get.width,
              duration: animatedDuration,
              curve: Curves.easeIn,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: Get.width,
                    height: 160,
                    decoration: BoxDecoration(
                        color: HuMapColor.mainColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: Get.width * 0.8),
                            SvgPicture.asset("assets/images/icons/people.svg")
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          width: 36,
                          height: 3,
                          decoration: BoxDecoration(
                              color: HuMapColor.grayFive,
                              borderRadius: BorderRadius.circular(1.5)
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () => controller.isMapOpen.value = !(controller.isMapOpen.value),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7), bottomLeft: Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(6),
                        offset: Offset(0, 4),
                        blurRadius: 10
                      )
                    ]
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/images/icons/map.svg"),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 48,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.find<AuthService>().logOut(),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: SvgPicture.asset("assets/images/icons/logout.svg"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => controller.isMoreOptionOpen.value = !(controller.isMoreOptionOpen.value),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: SvgPicture.asset("assets/images/icons/moreOption.svg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => print("onClick"),
                    child: Obx(() => Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ((controller.isMapOpen.value) ? Colors.transparent : Colors.white),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/icons/currentLocation.svg",
                          color: ((controller.isMapOpen.value) ? Colors.transparent : HuMapColor.mainColor),
                        ),
                      ),
                    )),
                  ),
                ],
              )
            ),
            Obx(() => Positioned(
              top: (controller.isMoreOptionOpen.value ? 0 : Get.height),
              child: GestureDetector(
                onTap: () => controller.isMoreOptionOpen.value = !(controller.isMoreOptionOpen.value),
                child: AnimatedContainer(
                  duration: optionAnimatedDuration,
                  curve: Curves.easeIn,
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black.withOpacity(controller.isMoreOptionOpen.value ? 0.5 : 0),
                ),
              ),
            )),
            Obx(() => AnimatedPositioned(
              top: 60,
              right: (controller.isMoreOptionOpen.value ? 24 : -50),
              duration: optionAnimatedDuration,
              curve: Curves.easeIn,
              child: GestureDetector(
                onTap: () => controller.isMoreOptionOpen.value = !(controller.isMoreOptionOpen.value),
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: SvgPicture.asset("assets/images/icons/close.svg", width: 14))
                ),
              )
            )),
            Obx(() => AnimatedPositioned(
              top: 52,
              duration: optionAnimatedDuration,
              curve: Curves.easeIn,
              right: (controller.isMoreOptionOpen.value ? 96 : -50),
              child: MoreOptionButton(btnType: MoreOptionButtonType.chat, clickAction: () => Get.toNamed(PageRoutes.CHATLIST))
            )),
            Obx(() => AnimatedPositioned(
                top: 124,
                duration: optionAnimatedDuration,
                curve: Curves.easeIn,
                right: (controller.isMoreOptionOpen.value ? 96 : -50),
                child: MoreOptionButton(btnType: MoreOptionButtonType.search, clickAction: () => print("onClick"))
            )),
            Obx(() => AnimatedPositioned(
                top: 148,
                duration: optionAnimatedDuration,
                curve: Curves.easeIn,
                right: (controller.isMoreOptionOpen.value ? 30 : -50),
                child: MoreOptionButton(btnType: MoreOptionButtonType.post, clickAction: () => print("onClick"))
            )),
          ],
        )
      ),
    );
  }
}





