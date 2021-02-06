import 'package:chat_app/app/data/model/user.dart';
import 'package:chat_app/app/modules/home/views/local_widget/carousel_tab_bar.dart';
import 'package:chat_app/app/modules/home/views/local_widget/user_card.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/util/constant.dart';
import 'package:chat_app/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.SEARCH);
        },
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
          // height: 90.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
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
      body: SafeArea(
        child: Column(
          children: [
            CarouselTabBar(),
            GetBuilder<HomeController>(
              builder: (_) {
                if (controller.users == null) return Container();
                return Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: controller.chatRepo.fetchContacts(
                      userId: controller.users.uid,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var docList = snapshot.data.docs;

                        return GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 9 / 11.7,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          padding: EdgeInsets.all(8),
                          children: docList
                              .map(
                                (e) => UserCardWidget(
                                  user: Users.fromMap(
                                    e.data(),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      }
                      return Container();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
