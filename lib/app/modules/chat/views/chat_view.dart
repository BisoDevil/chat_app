import 'package:chat_app/app/data/model/message.dart';
import 'package:chat_app/app/modules/chat/views/local_widget/chat_buuble.dart';

import 'package:chat_app/app/util/callUtil.dart';
import 'package:chat_app/app/util/constant.dart';
import 'package:chat_app/app/util/permission.dart';
import 'package:chat_app/app/util/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/index.dart';
import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:shape_of_view/shape_of_view.dart';

class ChatView extends GetView<ChatController> {
  final GlobalKey<FormState> _key =
      GlobalKey<FormState>(debugLabel: "chat_form_key");
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.only(
                bottom: 15,
              ),
              child: ShapeOfView(
                height: 100,
                width: .95.sw,
                clipBehavior: Clip.antiAlias,
                shape: BubbleShape(
                  arrowHeight: 50,
                  arrowWidth: 40,
                  borderRadius: 60,
                ),
                child: Container(
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Form(
                        key: _key,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: Constants.mainColor),
                                controller: textController,
                                onSaved: (newValue) =>
                                    controller.body = newValue,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Constants.mainColor,
                                  ),
                                  hintText: "Write a message",
                                ),
                              ),
                            ),
                            FloatingActionButton(
                              mini: true,
                              onPressed: () {
                                if (!_key.currentState.validate()) return;
                                _key.currentState.save();
                                _key.currentState.reset();
                                FocusScope.of(context).unfocus();
                                controller.sendMessage();
                              },
                              child: Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 110.h,
              child: BottomAppBar(
                elevation: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Constants.mainColor,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.body = "🤫";
                          controller.sendMessage();
                        },
                        child: Text(
                          "🤫",
                          style: Get.textTheme.headline4.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.shoPicker = true;
                          controller.update();
                        },
                        child: Text(
                          "🙂",
                          style: Get.textTheme.headline4.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.do_not_touch,
                        color: Colors.transparent,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.call,
                          size: 30,
                        ),
                        onPressed: () async {
                          if (await Permissions.microphonePermissionsGranted())
                            CallUtils.dialVoice(
                                from: controller.user,
                                to: controller.contact,
                                context: context,
                                callis: "audio");
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert_outlined,
                          size: 30,
                        ),
                        onPressed: () {
                          printInfo(info: "more pressed");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(CupertinoIcons.back),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            "${controller.contact?.profilePhoto ?? noImageAvailable}"),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GetBuilder<ChatController>(
                              builder: (_) {
                                return Text(
                                  "${controller.contact?.name ?? ""}",
                                  style: Get.textTheme.headline5.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            Text(
                              "Typing",
                              style: Get.textTheme.button.copyWith(
                                color: Constants.mainColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  GetBuilder<ChatController>(
                    builder: (_) {
                      if (_.user == null) return Container();
                      return Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(MESSAGES_COLLECTION)
                              .doc(controller.user.uid)
                              .collection(controller.contact.uid)
                              .orderBy(TIMESTAMP_FIELD, descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Center(child: CircularProgressIndicator());
                            }

                            return ListView.builder(
                              padding: EdgeInsets.all(8),
                              reverse: true,
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                var msg = Message.fromMap(
                                    snapshot.data.docs[index].data());
                                msg.isMe = msg.senderId == controller.user.uid;
                                return ChatBubble(
                                  message: msg,
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        GetBuilder<ChatController>(
          builder: (_) {
            if (!_.shoPicker) return Container();
            return EmojiPicker(
              onEmojiSelected: (emoji, category) {
                textController.text += emoji.emoji;
              },
            );
          },
        ),
      ],
    );
  }
}
