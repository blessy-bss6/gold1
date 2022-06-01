import 'package:flutter/material.dart';

import '../Elements/button.dart';
import '../common/orderContent.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: offWhiteColor,
                  border: Border(
                      bottom: BorderSide(width: 1.0, color: borderColor))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderIdContent(
                    t1: '#52525522',
                    t2: '24 Sep,2020',
                  ),
                  heightSizedBox(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                        t: 'items ',
                        style: labelTextStyle,
                      ),
                      Txt(
                        t: 'Rs. 250.00',
                        fontSize: 15,
                        color: Colors.green,
                      )
                    ],
                  ),
                  OrderItemShowList(
                    count: 2,
                  ),
                  heightSizedBox(5.0),
                  OrderItemStatus(status: 'Delivered', statusVal: 'Cancel')
                ],
              ),
            );
          }),
    );
  }
}

class OrderItemShowList extends StatefulWidget {
  int? count;
  OrderItemShowList({Key? key, this.count}) : super(key: key);

  @override
  State<OrderItemShowList> createState() => _OrderItemShowListState();
}

class _OrderItemShowListState extends State<OrderItemShowList> {
  int prodNumber = 10;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.count ?? prodNumber,
              itemBuilder: (context, i) =>
                  Txt(t: 'itemname', style: smallTextStyle)),
          Container(
            child: widget.count! < prodNumber
                ? InkWell(
                    onTap: () => setState(() {
                      widget.count = prodNumber;
                    }),
                    child: Txt(
                      t: 'view more',
                      fontSize: 10,
                      color: textBlueColor,
                    ),
                  )
                : widget.count == prodNumber
                    ? InkWell(
                        onTap: () => setState(() {
                          widget.count = 2;
                        }),
                        child: Txt(
                          t: 'view less',
                          fontSize: 10,
                          color: textBlueColor,
                        ),
                      )
                    : null,
          )
        ],
      ),
    );
  }
}

// ! Order Status
class OrderItemStatus extends StatelessWidget {
  final String? statusVal;
  final String? status;
  const OrderItemStatus({Key? key, this.status, this.statusVal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: statsBox(),
          ),
          IconTxtWid(
            txt: status ?? '',
            color: redColor,
            // icon:
          )
        ],
      ),
    );
  }

  Widget statsBox() {
    if (statusVal == 'Delivered') {
      return IconTxtWid(
        icon: Icons.add_task_rounded,
        txt: 'Delivered',
        color: offgreenColor,
      );
    }
    if (statusVal == 'Cancel') {
      return IconTxtWid(
        icon: Icons.cancel,
        txt: 'Cancel',
        color: redColor,
      );
    }

    return Container(
      child: Btn(
        height: 25,
        width: 80,
        btnName: 'TrackOrder',
        txtColor: txtWhiteColor,
        color: offgreenColor,
      ),
    );
  }
}

class IconTxtWid extends StatelessWidget {
  final String? txt;
  final IconData? icon;
  final Color? color;
  const IconTxtWid({Key? key, this.txt, this.color, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      IconBtn(
        icon: icon,
        color2: color,
        size: 18,
      ),
      Txt(
        t: txt ?? '',
        color: redColor,
      ),
    ]));
  }
}
