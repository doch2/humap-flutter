import 'package:get/get.dart';
import 'package:humap/services/chat_service.dart';

import 'controller.dart';

class ChatRoomPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatService());

    Get.lazyPut<ChatRoomPageController>(() => ChatRoomPageController());
  }
}
