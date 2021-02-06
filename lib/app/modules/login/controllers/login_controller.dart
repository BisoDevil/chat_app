import 'package:chat_app/app/data/repo/user_repo.dart';
import 'package:chat_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

class LoginController extends GetxController {
  var repo = UserRepo();
  String phone;

  String name;
  login() async {
    var user = await repo.signIn(phone, name);
    if (user != null) Get.offAllNamed(Routes.HOME);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    var us = await repo.getCurrentUser();
    if (us != null) Get.offAllNamed(Routes.HOME);
    super.onReady();
  }
}
