import 'package:chat_app/app/util/constant.dart';
import 'package:flutter/material.dart';

import 'app/routes/app_pages.dart';
import 'index.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(750, 1334),
      child: OKToast(
        position: ToastPosition.center,
        child: GetMaterialApp(
          initialRoute: AppPages.INITIAL,
          defaultTransition: Transition.cupertino,
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: Constants.mainColor,
            accentColor: Constants.mainColor,
            buttonTheme: ButtonThemeData(
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  25,
                ),
              ),
              buttonColor: Constants.mainColor,
            ),
          ),
          getPages: AppPages.routes,
        ),
      ),
    ),
  );
}
