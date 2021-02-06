import 'package:get/get.dart';

import 'package:chat_app/app/modules/chat/bindings/chat_binding.dart';
import 'package:chat_app/app/modules/chat/views/chat_view.dart';
import 'package:chat_app/app/modules/home/bindings/home_binding.dart';
import 'package:chat_app/app/modules/home/views/home_view.dart';
import 'package:chat_app/app/modules/login/bindings/login_binding.dart';
import 'package:chat_app/app/modules/login/views/login_view.dart';
import 'package:chat_app/app/modules/search/bindings/search_binding.dart';
import 'package:chat_app/app/modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
  ];
}
