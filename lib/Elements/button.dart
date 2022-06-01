import 'package:flutter/material.dart';
import '../utils/style.dart';

class Txt extends StatelessWidget {
  final String? t;
  final Color? color;
  final double? fontSize;
  final TextStyle? style;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDecoration? decoration;

  const Txt(
      {Key? key,
      this.t,
      this.color,
      this.fontFamily,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.maxLines,
      this.style,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      t ?? '',
      textAlign: textAlign ?? null,
      maxLines: maxLines ?? null,
      style: style ??
          TextStyle(
            decoration: decoration,
            color: color ?? null,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? null,
            fontFamily: fontFamily ?? poppinsMedium,
          ),
    );
  }
}

// ! Button For Everything Screen
class Btn extends StatelessWidget {
  final String? btnName;
  final dynamic onTap;
  final TextStyle? style;
  final double? width;
  final double? height;
  final Color? color, txtColor;

  final EdgeInsets? padding, margin;
  final Alignment? alignment;
  const Btn(
      {Key? key,
      this.alignment,
      this.btnName,
      this.color,
      this.txtColor,
      this.width,
      this.height,
      this.onTap,
      this.padding,
      this.margin,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
            bottomLeft: Radius.circular(3),
            bottomRight: Radius.circular(3),
          ),
        ),
        width: width ?? null,
        height: height ?? null,
        child: Center(
          child: Txt(
            t: btnName!,
            color: txtColor ?? txtWhiteColor,
            style: style ?? null,
          ),
        ),
      ),
    );
  }
}

class IconBtn extends StatelessWidget {
  final dynamic onPressed;
  final IconData? icon;
  final double? size;
  final Color? color;
  final Color? color2;
  const IconBtn(
      {Key? key, this.onPressed, this.icon, this.color2, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color2,
      ),
      iconSize: size ?? 20,
      color: color,
    );
  }
}

class CartBtn extends StatelessWidget {
  final dynamic plusBtn;
  final dynamic minusBtn;
  final Color? color;
  final dynamic cartItem;
  const CartBtn(
      {Key? key, this.color, this.plusBtn, this.cartItem, this.minusBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      // width: getWidth(context) / 4,
      alignment: Alignment.center,
      width: 70,
      decoration: BoxDecoration(
          border: Border.all(width: .9, color: Colors.black12),
          borderRadius: BorderRadius.circular(3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              // alignment: Alignment.topLeft,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: Icon(Icons.remove),
                iconSize: 18,
                color: color,
                onPressed: minusBtn,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '$cartItem',
              ),
            ),
          ),
          Expanded(
            child: Container(
              // alignment: Alignment.topRight,
              child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(Icons.add),
                  iconSize: 18,
                  color: color,
                  onPressed: () => plusBtn),
            ),
          )
        ],
      ),
    );
  }
}

class CartBtn2 extends StatelessWidget {
  final dynamic cartItem;
  final Color? color;
  final dynamic onPressed1;
  final dynamic onPressed2;
  CartBtn2({this.cartItem, this.color, this.onPressed1, this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      // width: getWidth(context) / 4,
      alignment: Alignment.center,
      width: 70,
      decoration: BoxDecoration(
          border: Border.all(width: .9, color: Colors.black12),
          borderRadius: BorderRadius.circular(3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              // alignment: Alignment.topLeft,
              child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(Icons.remove),
                  iconSize: 18,
                  color: color,
                  onPressed: onPressed1),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                ' $cartItem ',
              ),
            ),
          ),
          Expanded(
            child: Container(
              // alignment: Alignment.topRight,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: Icon(Icons.add),
                iconSize: 18,
                color: color,
                onPressed: onPressed2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
