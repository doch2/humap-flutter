import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:humap/services/auth_service.dart';
import 'package:humap/services/realtime_database.dart';
import 'package:random_string/random_string.dart';

import 'firestore_database.dart';

class ChatService extends GetxController {
  late String nowChatRoomID, nowUserID;

  List chatRoomList = [];
  Map chatRoomInfo = {};

  Map miniUserInfo = {};

  @override
  void onInit() {
    super.onInit();

    nowUserID = Get.find<AuthService>().user.id!;
  }

  sendMessage(String message) {
    RealtimeDatabase().sendMessage(nowChatRoomID, nowUserID, "text", message);
  }

  createChatRoom() {
    String roomID = randomAlphaNumeric(25);

    FirestoreDatabase().createChatRoom("테스트채팅방", [nowUserID], nowUserID, roomID);
  }

  Future<bool> getChatRoomList() async {
    chatRoomList = await FirestoreDatabase().getChatList(nowUserID);


    for (int i=0; i < chatRoomList.length; i++) {
      chatRoomInfo[chatRoomList[i]] = await FirestoreDatabase().getChatRoom(chatRoomList[i]);

      List tempMemberList = chatRoomInfo[chatRoomList[i]]["memberList"];
      for (var userID in tempMemberList) {
        miniUserInfo[userID] = await FirestoreDatabase().getUserInfoForChat(userID);
      }
    }

    return true;
  }
}