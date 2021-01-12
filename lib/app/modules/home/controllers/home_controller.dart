import 'package:chat_app/app/data/model/user.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<User> users;
  @override
  void onInit() {
    super.onInit();
    users = List.generate(
      50,
      (index) => User(
        imageUrl:
            "https://qodebrisbane.com/wp-content/uploads/2019/07/This-is-not-a-person-2-1.jpeg",
        count: 4,
        lastMessage: "Hellow yad enta maslan ",
        name: "Ahmed Atef $index",
      ),
    ).toList();
  }
}
