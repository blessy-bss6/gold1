// import 'package:comp1/util/common.dart';
// import 'package:flutter/services.dart';

// DateTime now1 = DateTime.now();

// late DateTime currentBackPressTime = DateTime(now1.day - 1);

// Future<bool> onWillPop() async {
//   DateTime now = DateTime.now();
//   if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
//     currentBackPressTime = now;
//     flutterToast('Tap again to close app');
//     return Future.value(false);
//   }
//   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//   return Future.value(true);
// }

// late DateTime pre_backpress = DateTime.now();
//
// Future<bool> onWillPop() async {
//
//   final timegap = DateTime.now().difference(pre_backpress);
//   final cantExit = timegap >= Duration(seconds: 2);
//   pre_backpress = DateTime.now();
//   if (cantExit) {
//     Fluttertoast.showToast(
//       msg: 'Tap again to close app',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//     );
//     return false;
//   } else {
//     // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//     return true;
//   }
// }
