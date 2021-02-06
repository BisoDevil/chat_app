import 'package:chat_app/app/data/model/user.dart';
import 'package:chat_app/app/data/repo/contact_repo.dart';
import 'package:chat_app/app/data/repo/user_repo.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  List<Users> userList;
  UserRepo userRepo = UserRepo();

  ContactMethods contactMethods = ContactMethods();
  @override
  void onInit() {
    _fetchUser();
    super.onInit();
  }

  _fetchUser() async {
    var user = await userRepo.getCurrentUser();
    userList = await userRepo.fetchAllUsers(user);
    update();
  }

  startChat(Users rec) {
    contactMethods.addContactToDb(userRepo.getUser, rec);
  }

  @override
  void onReady() {
    super.onReady();
  }
}
