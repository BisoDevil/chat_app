import 'dart:math';
import 'package:chat_app/app/data/model/call.dart';
import 'package:chat_app/app/data/model/user.dart';
import 'package:chat_app/app/data/repo/call_repo.dart';
import 'package:chat_app/app/modules/call/videocall_screen.dart';
import 'package:chat_app/app/modules/call/voicecall_screen.dart';
import 'package:flutter/material.dart';

// import 'package:chatapp/utils/utilities.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dialVideo({Users from, Users to, context, String callis}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeVideoCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoCallScreen(call: call),
          ));
    }
  }

  static dialVoice({Users from, Users to, context, String callis}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeVoiceCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoiceCallScreen(call: call),
          ));
    }
  }
}
