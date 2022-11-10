import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:humap/common_widgets/chat_profile_image.dart';
import 'package:humap/themes/color_theme.dart';

import '../../services/realtime_database.dart';
import '../../themes/text_theme.dart';
import 'controller.dart';


class ChatRoomPage extends GetWidget<ChatRoomPageController> {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    final messageTextController = TextEditingController();
    final messageViewController = ScrollController();

    DatabaseReference messageRef = RealtimeDatabase().getMessageDatabase(controller.chatService.nowChatRoomID);

    Timer(
      Duration(seconds: 1),
          () => messageViewController.jumpTo(messageViewController.position.maxScrollExtent),
    );

    return Scaffold(
      backgroundColor: blueOne,
      body: Center(
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(width: Get.width),
                          Positioned(
                            left: 16,
                            child: GestureDetector(onTap: () => Get.back(), child: SvgPicture.asset("assets/images/icons/leftArrow.svg")),
                          ),
                          Positioned(
                            child: Text("${controller.chatService.miniUserInfo[controller.chatService.chatRoomInfo[controller.chatService.nowChatRoomID]['memberList'][0]]['name']}", style: chatPage_title),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      flex: 10,
                      child: FirebaseAnimatedList(
                        query: messageRef,
                        controller: messageViewController,
                        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                          Map chatData = (snapshot.value as Map);
                          Map personData = controller.chatService.miniUserInfo[chatData["user"]];

                          return GestureDetector(
                            onTap: () => messageRef.child(snapshot.key!).remove(),
                            child: Column(
                              children: [
                                SizeTransition(
                                  sizeFactor: animation,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 20),
                                          ChatProfileImage(sizeType: ChatProfileImageSizeType.small, profileImgURL: personData['profileImg']),
                                          const SizedBox(width: 20),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${personData["name"]}',
                                                style: chatPage_chatBubble_name,
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                width: (chatPage_chatBubble_content.fontSize! * (chatData['content'] as String).length * 1.4),
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Center(
                                                    child: Text("${chatData["content"]}", style: chatPage_chatBubble_content)
                                                ),
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      Container(width: Get.width, child: Divider(height: 2, color: grayNine)),
                      Container(
                        width: Get.width,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: _width * 0.8,
                              child: TextField(
                                controller: messageTextController,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: null,
                                style: chatPage_textField.copyWith(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: '메세지를 입력하세요',
                                  hintStyle: chatPage_textField,
                                  contentPadding: EdgeInsets.symmetric(vertical: _height * 0.02),
                                  border: OutlineInputBorder(borderSide: BorderSide(width: 0, style: BorderStyle.none,)),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.sendMessage(messageTextController.text);
                                messageTextController.clear();
                              },
                              child: SvgPicture.asset("assets/images/icons/send.svg"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                )
              ],
            )
          )
      ),
    );
  }
}