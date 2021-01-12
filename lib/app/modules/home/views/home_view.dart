import 'package:chat_app/app/modules/home/views/local_widget/user_card.dart';
import 'package:chat_app/app/util/constant.dart';
import 'package:chat_app/index.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/floating_background.svg',
            ),
            Icon(
              Icons.add,
              color: Colors.white,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        elevation: 8,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Constants.mainColor,
        child: Container(
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.home,
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.userAlt,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ],
          ),
          // color: Constants.mainColor,
        ),
        shape: CircularNotchedRectangle(),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 9 / 11.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        padding: EdgeInsets.all(8),
        children: controller.users
            .map(
              (e) => UserCardWidget(
                user: e,
              ),
            )
            .toList(),
      ),
    );
  }
}
