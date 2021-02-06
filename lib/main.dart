import 'package:chat_app/app/util/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/routes/app_pages.dart';
import 'index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Constants.mainColor,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            scaffoldBackgroundColor: Constants.scaffoldBackgroundColor,
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
