import 'dart:async';
import 'package:flutter/material.dart';

import '../Elements/imgScr.dart';

import '../Screen/bottomNav.dart';
import '../utils/common.dart';
import '../utils/shared_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedHelper sharedHelper = SharedHelper();

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    bool isLogin = await sharedHelper.containsKey('current_user');
    bool isD = await sharedHelper.containsKey('userIdType');
    print('userid $isLogin');
    print('isid $isD');
    if (isLogin) {
      dynamic id = await sharedHelper.getUserTypeScr('userIdType');

      navigationRemoveUntil(
          context,
          UserNavigationBar(
            currentTab: 0,
          ));
    } else {
      Timer(
          Duration(seconds: 2),
          () => navigationRemoveUntil(
              context,
              UserNavigationBar(
                currentTab: 0,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Pics(
            src: 'assets/imgs/goldspalsh.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
