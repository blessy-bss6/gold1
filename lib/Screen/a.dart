import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class CheckProd extends StatefulWidget {
  CheckProd({Key? key}) : super(key: key);

  @override
  State<CheckProd> createState() => _CheckProdState();
}

class _CheckProdState extends State<CheckProd> {
  List<dynamic> data = [];
  String? htmlData;
  @override
  void initState() {
    htmlRemove();
    super.initState();
  }

  htmlRemove() {
    String html =
        '<div><p>Hello</p>This is <br/>fluttercampus.com<span>,Bye!</span></div>';

    var doc = parse(html);
    if (doc.documentElement != null) {
      String parsedstring = doc.documentElement!.text;
      print(parsedstring);
      setState(() {
        htmlData = parsedstring;
      });
      //output without space: HelloThis is fluttercampus.com,Bye!
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child:Center(
                  child: Text(htmlData.toString()),
                )),
    );
  }
}

// import '../utils/shared_helper.dart';

// ShopC shoping = ShopC();
// dynamic userList = shoping.refreshItems();

// final subPriceList = [];
// final mrpPriceList = [];
// dynamic subPrice = 0;
// dynamic mrpPrice = 0;
// dynamic shipPrice = 0;
// dynamic totalPrice;
// calculatePrice() {
//   for (var i in userList) {
//     subPriceList.add(i['sale_price']);
//     mrpPriceList.add(i['regular_price']);
//   }

//   subPrice = subPriceList.reduce((a, b) => a + b);

//   mrpPrice = mrpPriceList.reduce((a, b) => a + b);

//   if (subPrice < 499) {
//     shipPrice = 700;
//   }
//   return  {"subPrice" :subPrice,"mrpPrice":mrpPrice,"shipPrice":shipPrice} ;
// }
