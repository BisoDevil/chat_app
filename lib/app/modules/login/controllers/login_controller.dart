import 'package:chat_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String phone;
  login() {
    Get.offAllNamed(Routes.HOME);
  }
}
