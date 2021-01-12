import 'package:flutter/material.dart';

import 'package:chat_app/index.dart';

import 'package:chat_app/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            height: 1.sh,
            width: 1.sw,
            alignment: Alignment.center,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 5,
              ),
              Text(
                "Chat APP",
                style: Get.textTheme.headline3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(
                flex: 3,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Phone number",
                ),
                onChanged: (value) => controller.phone = value,
              ),
              Spacer(
                flex: 2,
              ),
              RaisedButton(
                onPressed: controller.login,
                child: Text(
                  "Login",
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ).paddingSymmetric(
            horizontal: 30,
          )
        ],
      ),
    );
  }
}
