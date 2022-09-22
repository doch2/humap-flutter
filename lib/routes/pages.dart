import 'package:get/get.dart';

import '../middleware/LoginMiddleware.dart';
import '../pages/home/binding.dart';
import '../pages/home/page.dart';
import '../pages/login/binding.dart';
import '../pages/login/page.dart';
import 'routes.dart';

class SinibankPages {
  static final pages = [
    GetPage(name: PageRoutes.HOME, page: () => const HomePage(), binding: HomePageBinding(), middlewares: [LoginMiddleware()]),
    GetPage(name: PageRoutes.LOGIN, page: () => const LoginPage(), binding: LoginPageBinding()),
  ];
}
