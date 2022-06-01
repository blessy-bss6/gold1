import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';

SizedBox heightSizedBox(height) {
  return SizedBox(
    height: height,
  );
}

SizedBox widthSizedBox(width) {
  return SizedBox(
    width: width,
  );
}

Divider divider() {
  return Divider(
    height: 1,
    color: Colors.black38,
  );
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getTop(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

navigationRemoveUntil(BuildContext context, Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false);
}

navigationPushReplacement(BuildContext context, {Widget? widget}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) =>  widget!));
}

Future navigationPush(BuildContext context, Widget widget) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => widget));
}

navigationPop(BuildContext context) {
  Navigator.of(context).pop();
}

Container verticalDivider(height) {
  return Container(height: height, width: 1, color: Colors.black26);
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    BuildContext context, String message,
    {Color? bgColor, Color? color, double? fontSize}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bgColor,
      content: Text(
        message,
        style: TextStyle(color: color, fontSize: fontSize),
      ),
    ),
  );
}

Future<bool> willPopCallback(BuildContext context, bool page,
    {Widget? widget}) async {
  navigationPushReplacement(context, widget: widget);
  return Future.value(page);
}

// Future<bool?> flutterToast(String message) {
//   return Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: Colors.grey.shade700,
//   );
// }

void closeKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

List<TextInputFormatter> digitsInputFormatter({int? size}) {
  return [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(size ?? 10),
  ];
}

// OverlayEntry overlayLoader(context) {
//   OverlayEntry loader = OverlayEntry(builder: (context) {
//     final size = MediaQuery.of(context).size;
//     return Positioned(
//       height: size.height,
//       width: size.width,
//       top: 0,
//       left: 0,
//       child: Material(
//         color: Colors.white.withOpacity(0.85),
//         child: Loader(height: 200),
//       ),
//     );
//   });
//   return loader;
// }

// removeLoader(OverlayEntry loader) {
//   Timer(Duration(milliseconds: 500), () {
//     try {
//       loader.remove();
//     } catch (e) {}
//   });
// }
