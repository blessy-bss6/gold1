import 'package:flutter/material.dart';

import '../Elements/button.dart';
import '../utils/common.dart';

import '../utils/style.dart';

class AddressPart extends StatelessWidget {
  final Widget? trailing;
  const AddressPart({Key? key, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            t: 'Delivery Location',
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                IconBtn(
                  icon: Icons.location_on,
                  size: 30,
                  // height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        t: 'Your Location',
                        fontSize: 13,
                      ),
                      Txt(t: '55, bagHouse , kota,Kota'),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                alignment: Alignment.topRight,
                child: trailing != null
                    ? IconBtn(icon: Icons.chevron_right)
                    : null),
          ]),
        ],
      ),
    );
  }
}

// ! Price List
class PriceList extends StatelessWidget {
  final String? heading;

  final BoxDecoration? decoration;
  final dynamic subPrice;
  final dynamic mrpPrice;
  final dynamic shipPrice;

  const PriceList({
    Key? key,
    this.heading,
    this.mrpPrice,
    this.shipPrice,
    this.subPrice,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Column(
        children: [
          Container(
            child: heading != null
                ? Text(
                    heading ?? '',
                    style: labelTextStyle,
                  )
                : null,
          ),
          datas(
            t1: 'Subtotal',
            t2: 'Rs $subPrice',
          ),
          datas(
            t1: 'Shpping Charge',
            t2: 'Rs $shipPrice',
          ),
          datas(
              t1: 'Total Discount',
              t2: '- Rs ${mrpPrice - subPrice}',
              style: TextStyle(color: offgreenColor, fontSize: 15)),
          // datas(
          //   t1: 'Tax Charge',
          //   t2: 'Rs 00.00',
          // ),
          // datas(
          //     t1: 'Promo Code',
          //     t2: '- Rs 400',
          //     style: TextStyle(color: offgreenColor, fontSize: 15)),
          heightSizedBox(3.0),
          Container(
              // margin: EdgeInsets.all(),
              decoration: BoxDecoration(color: brownWhiteColor),
              padding: EdgeInsets.all(5),
              child: datas(
                t1: 'Total ',
                t2: 'Rs${subPrice + shipPrice}',
              ))
        ],
      ),
    );
  }

  Widget datas({String? t1, String? t2, TextStyle? style}) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 1, bottom: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(
            t: t1,
            style: style ?? labelTextStyle,
          ),
          Txt(
            t: t2,
            style: style ?? labelTextStyle,
          )
        ],
      ),
    );
  }
}

// 1 BASIC PRODUCT
class BasicProdDetail extends StatelessWidget {
  final dynamic prodNumber;
  final bool? cartBtn, mrpTxt;
  final dynamic price;
  final dynamic quantity;
  final dynamic fullPrice;
  const BasicProdDetail(
      {Key? key,
      this.quantity,
      this.price,
      this.fullPrice,
      this.prodNumber,
      this.cartBtn,
      this.mrpTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Txt(
          t: '${prodNumber['name'].toString().length >= 20 ? prodNumber['name'].toString().substring(0, 20)
              // +  "\n" + prodNumber['name'].toString().substring(20, 40)
              : prodNumber['name']}',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        Txt(
          t: '${prodNumber['quantity']}',
          fontSize: 17,
          color: greyColor,
        ),
        Row(
          children: [
            Container(
              child: Txt(
                t: 'MRP : Rs${prodNumber['regular_price'] } ',
                decoration: TextDecoration.lineThrough,
                fontSize: 13,
                color: greyColor,
              ),
            ),

            // widthSizedBox(2.0),
            Txt(
              t: 'Rs ${prodNumber['sale_price']}',
              style: labelTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}

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
