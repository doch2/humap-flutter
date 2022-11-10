import 'package:get/get.dart';
import 'package:humap/middleware/LandingMiddleware.dart';
import 'package:humap/pages/chat_list/binding.dart';
import 'package:humap/pages/chat_list/page.dart';
import 'package:humap/pages/contact_info_connect_agree/page.dart';
import 'package:humap/pages/landing/page.dart';
import 'package:humap/pages/network_making/binding.dart';
import 'package:humap/pages/network_making/page.dart';
import 'package:humap/pages/privacy_policy_agree/page.dart';

import '../middleware/LoginMiddleware.dart';
import '../pages/chat_room/binding.dart';
import '../pages/chat_room/page.dart';
import '../pages/home/binding.dart';
import '../pages/home/page.dart';
import '../pages/login/binding.dart';
import '../pages/login/page.dart';
import 'routes.dart';

class HumapPages {
  static final pages = [
    GetPage(name: PageRoutes.HOME, page: () => const HomePage(), binding: HomePageBinding(), middlewares: [LoginMiddleware()]),
    GetPage(name: PageRoutes.LOGIN, page: () => const LoginPage(), binding: LoginPageBinding(), middlewares: [LandingMiddleware()]),
    GetPage(name: PageRoutes.LANDING, page: () => const LandingPage()),
    GetPage(name: PageRoutes.PRIVACYPOLICYAGREE, page: () => const PrivacyPolicyAgreePage()),
    GetPage(name: PageRoutes.CONTACTINFOCONNECTAGREE, page: () => const ContactInfoConnectAgreePage()),
    GetPage(name: PageRoutes.NETWORKMAKING, page: () => const NetworkMakingPage(), binding: NetworkMakingPageBinding()),
    GetPage(name: PageRoutes.CHATLIST, page: () => const ChatListPage(), binding: ChatListPageBinding()),
    GetPage(name: PageRoutes.CHATROOM, page: () => const ChatRoomPage(), binding: ChatRoomPageBinding()),
  ];
}
