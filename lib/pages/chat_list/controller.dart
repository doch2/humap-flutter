import 'package:get/get.dart';
import 'package:humap/services/chat_service.dart';

class ChatListPageController extends GetxController with StateMixin {
  late ChatService chatService;


  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();

    chatService = Get.find<ChatService>();
  }

  createChatRoom() => chatService.createChatRoom();

  getChatRoomList() async => await chatService.getChatRoomList();
}