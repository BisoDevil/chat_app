import 'package:chat_app/app/data/repo/call_repo.dart';
import 'package:chat_app/app/data/repo/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupLayout({
    @required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    final UserRepo userProvider = UserRepo();

    return (userProvider != null && userProvider.getUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: userProvider.getUser.uid),
            builder: (context, snapshot) {
              // if (snapshot.hasData && snapshot.data.data != null) {
              //   // Call call = Call.fromMap(snapshot.data.data());

              //   if (!call.hasDialled) {
              //     return PickupScreen(call: call);
              //   }
              // }
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
