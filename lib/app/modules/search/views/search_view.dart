import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/util/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chat_app/app/modules/search/controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
          centerTitle: true,
        ),
        body: GetBuilder<SearchController>(
          builder: (_) {
            if (_.userList == null) return Container();
            return ListView(
                children: _.userList
                    .map(
                      (e) => ListTile(
                        title: Text(e.name ?? ""),
                        trailing: FlatButton(
                          color: Constants.mainColor,
                          child: Text("Chat"),
                          onPressed: () {
                            _.startChat(e);
                            Get.toNamed(Routes.CHAT, arguments: e);
                          },
                        ),
                      ),
                    )
                    .toList());
          },
        ));
  }
}
