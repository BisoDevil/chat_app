import 'package:chat_app/app/data/model/message.dart';
import 'package:chat_app/app/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/index.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Bubble(
        color: message.isMe ? Constants.chatBubbleColor : Colors.grey[300],
        elevation: 3,
        nipWidth: 8,
        radius: Radius.circular(12),
        padding: BubbleEdges.all(8),
        margin: BubbleEdges.only(
            top: 10,
            right: message.isMe ? 0 : .2.sw,
            left: message.isMe ? .2.sw : 0),
        nip: message.isMe ? BubbleNip.rightBottom : BubbleNip.leftBottom,
        stick: true,
        alignment: message.isMe ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: Get.textTheme.button
                  .copyWith(color: message.isMe ? null : Colors.black),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "${DateFormat.Hm().format(message.timestamp.toDate())}",
              style: Get.textTheme.caption
                  .copyWith(color: message.isMe ? null : Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
