import 'package:flutter/material.dart';
import '../Elements/button.dart';
import '../utils/style.dart';

class OrderIdContent extends StatelessWidget {
  final dynamic statTxt;
  final String? t1;
  final String? t2;
  final Color? color;
  const OrderIdContent({Key? key, this.statTxt, this.t1, this.t2, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                t: t1 ?? '',
                style: labelTextStyle,
              ),
              Container(
                  child: statTxt != null
                      ? Txt(
                          t: statTxt ?? '',
                          color: color ?? orangeColor,
                        )
                      : null)
            ],
          ),
          Txt(
            t: t2 ?? '',
            style: smallTextStyle,
          ),
        ],
      ),
    );
  }
}

// !n
class OrderIdAdrContent extends StatelessWidget {
  final dynamic onChanged;
  final dynamic groupVal;
  final String? t2;
  final String? t1;
  final dynamic value;
  const OrderIdAdrContent(
      {Key? key, this.value, this.t1, this.groupVal, this.onChanged, this.t2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            t: t1,
            style: labelTextStyle,
          ),
          // Container(
          //   child: RadioListTile(
          //     value: value,
          //     groupValue: groupVal,
          //     onChanged: onChanged,
          //     title: Txt(t: t2),
          //   ),
          // ),
          Container(
            height: 30,
            child: Row(
              children: [
                Radio(
                  activeColor: offgreenColor,
                  value: value,
                  groupValue: groupVal,
                  onChanged: onChanged,
                ),
                Txt(t: t2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
