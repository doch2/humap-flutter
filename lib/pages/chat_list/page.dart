import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexagon/hexagon.dart';
import 'package:humap/common_widgets/chat_profile_image.dart';
import 'package:humap/routes/routes.dart';

import '../../themes/color_theme.dart';
import '../../themes/text_theme.dart';
import 'controller.dart';

class ChatListPage extends GetWidget<ChatListPageController> {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(width: Get.width),
                  Positioned(
                    left: 16,
                    child: GestureDetector(onTap: () => Get.back(), child: SvgPicture.asset("assets/images/icons/leftArrow.svg")),
                  ),
                  const Positioned(
                    child: Text("채팅", style: chatPage_title),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.1,),
              FutureBuilder(
                  future: controller.getChatRoomList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) { //데이터를 정상적으로 받았을때
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width:  Get.width,
                            height: Get.height * 0.5,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              itemCount: controller.chatService.chatRoomList.length,
                              itemBuilder: (context, index) {
                                String chatRoomID = controller.chatService.chatRoomList[index];
                                String chatRoomPersonID = controller.chatService.chatRoomInfo[chatRoomID]['memberList'][0];
                                Map chatRoomPersonInfo = controller.chatService.miniUserInfo[chatRoomPersonID];

                                return Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          controller.chatService.nowChatRoomID = controller.chatService.chatRoomList[index];
                                          Get.toNamed(PageRoutes.CHATROOM);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: ChatProfileImage(sizeType: ChatProfileImageSizeType.big, profileImgURL: chatRoomPersonInfo['profileImg']),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("${controller.chatService.chatRoomInfo[controller.chatService.chatRoomList[index]]["title"]}", style: chatPage_personName),
                                                    const SizedBox(height: 4),
                                                    Text("${chatRoomPersonInfo['name']}님과의 대화를 확인해보세요.", style: chatPage_chatPreview),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                    const SizedBox(height: 12),
                                    Container(child: Divider(height: 1, color: graySix))
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) { //데이터를 정상적으로 불러오지 못했을 때
                      return Column(
                        children: [
                          Text("데이터를 정상적으로 불러오지 못했습니다. \n다시 시도해 주세요.", textAlign: TextAlign.center)
                        ],
                      );
                    } else { //데이터를 불러오는 중
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(child: CircularProgressIndicator()),
                        ],
                      );
                    }
                  }
              ),
            ],
          ),
        )
      ),
    );
  }
}