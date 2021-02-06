import 'package:chat_app/app/data/model/message.dart';
import 'package:chat_app/app/data/model/user.dart';
import 'package:chat_app/app/data/repo/chat_repo.dart';
import 'package:chat_app/app/data/repo/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../index.dart';

class ChatController extends GetxController {
  Users user;
  Users contact;
  String body;
  UserRepo userRepo = UserRepo();
  ChatRepo chatRepo = ChatRepo();
  bool shoPicker = false;

  @override
  Future<void> onInit() async {
    user = await userRepo.getUserDetails();
    contact = Get.arguments;
    update();
    super.onInit();
  }

  sendMessage() async {
    Message _message = Message(
      receiverId: contact.uid,
      senderId: user.uid,
      message: body,
      timestamp: Timestamp.now(),
      type: 'text',
    );

    body = "";
    chatRepo.addMessageToDb(_message, user, contact);
    shoPicker = false;
    update();
  }
}
