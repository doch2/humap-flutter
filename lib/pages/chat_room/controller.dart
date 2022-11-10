import 'package:get/get.dart';
import 'package:humap/services/chat_service.dart';

class ChatRoomPageController extends GetxController with StateMixin {
  late ChatService chatService;


  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();

    chatService = Get.find<ChatService>();
  }

  sendMessage(String message) => chatService.sendMessage(message);
}