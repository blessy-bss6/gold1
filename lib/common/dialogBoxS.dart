import 'package:flutter/material.dart';
import '../utils/style.dart';

// ! Alert Dialog Box
class AlertBox extends StatelessWidget {
  final String? title;
  final Widget? child;
  const AlertBox({Key? key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: AlertDialog(
        title: Center(
            child: Text(
          title!,
        )),
        content: child,
        actions: <Widget>[
          // show == 1
          // ?
          TextButton(
              child: Text('Ok', style: TextStyle(color: darkBlueColor)),
              onPressed: () => Navigator.pop(context))
        ],
      ),
    ));
  }
}
