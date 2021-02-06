import 'package:chat_app/app/data/repo/chat_repo.dart';
import 'package:chat_app/app/data/repo/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ChatRepo chatRepo = ChatRepo();
  UserRepo userRepo = UserRepo();
  User users;
  @override
  Future<void> onInit() async {
    users = await userRepo.getCurrentUser();
    update();
    super.onInit();
  }
}
