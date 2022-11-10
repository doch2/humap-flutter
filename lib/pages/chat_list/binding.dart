import 'package:get/get.dart';

import '../../services/chat_service.dart';
import 'controller.dart';

class ChatListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatService());

    Get.lazyPut<ChatListPageController>(() => ChatListPageController());
  }
}
