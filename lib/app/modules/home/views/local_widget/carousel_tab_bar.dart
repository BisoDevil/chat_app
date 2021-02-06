import 'package:chat_app/app/util/constant.dart';
import 'package:flutter/material.dart';

import '../../../../../index.dart';

class CarouselTabBar extends StatefulWidget {
  @override
  _CarouselTabBarState createState() => _CarouselTabBarState();
}

class _CarouselTabBarState extends State<CarouselTabBar> {
  final List<String> titles = ["Call", "Chat", "Near by"];
  int index = 1;

  Widget _cardText(String text, Color color) {
    return Container(
      width: .4.sw,
      height: 70.h,
      child: Card(
        elevation: 50,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            60,
          ),
        ),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: Get.textTheme.headline6,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _cardText("call", Constants.scaffoldBackgroundColor),
              _cardText("Near by", Constants.scaffoldBackgroundColor),
            ],
          ),
        ),
        Center(child: _cardText("Chat", Constants.mainColor)),
      ],
    );
  }
}
