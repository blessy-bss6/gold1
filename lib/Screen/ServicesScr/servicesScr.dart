import 'package:flutter/material.dart';
import '/Elements/baseAppbar.dart';

import '../../utils/style.dart';

class ServicesScreen extends StatelessWidget {
  final List lName;
  final String? title;
  ServicesScreen({Key? key, this.title, required this.lName}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: title ?? '',
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: lName.length,
            itemBuilder: (context, i) {
              if (i % 2 == 0) {
                return Container(
                    margin: EdgeInsets.only(bottom: 5, top: 10),
                    child: Text(
                      lName[i].toString(),
                      style: labelTextStyle,
                    ));
              }

              if (i % 2 == 1) {
                return Container(child: Text(lName[i].toString()));
              }

              return Text('');
            },
          ),
        ));
  }
}

class ServicesScreen2 extends StatelessWidget {
  final String? title;
  final List lName;
  const ServicesScreen2({Key? key, this.title, required this.lName})
      : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: title ?? '',
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: lName.length,
            itemBuilder: (context, i) {
              if (i % 2 == 0) {
                return Container(child: Text(lName[i].toString()));
              }
              if (i % 2 == 1) {
                return Container(
                    margin: EdgeInsets.only(bottom: 5, top: 10),
                    child: Text(
                      lName[i].toString(),
                      style: labelTextStyle,
                    ));
              }

              return Text('');
            },
          ),
        ));
  }
}
