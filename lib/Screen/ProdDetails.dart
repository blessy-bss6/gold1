import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import '../Backend/Bloc/prod_Bloc.dart';
import '../Backend/Resp/prod_home_Resp.dart';
import '../Elements/baseAppbar.dart';
import '../Elements/button.dart';
import '../Elements/imgScr.dart';
import '../utils/common.dart';
import '../utils/style.dart';

import '../Backend/Bloc/localCart_Bloc.dart';
import '../utils/htmlRemove.dart';
import 'cartScr.dart';

class ProdDetailScreen extends StatefulWidget {
  final dynamic prodNumber;
  ProdDetailScreen({Key? key, this.prodNumber}) : super(key: key);

  @override
  State<ProdDetailScreen> createState() => _ProdDetailScreenState();
}

class _ProdDetailScreenState extends State<ProdDetailScreen> {
  dynamic listImgSrc;

  imgcallBack(dynamic imgSrc) {
    // print('callBack $imgSrc');
    setState(() {
      listImgSrc = imgSrc;
    });
  }

  dynamic varitonData;

  ProdHomeRespo prodVerResp = ProdHomeRespo();

  dynamic description;
  @override
  void initState() {
    // TODO: implement initState
    vartionFun();
    htmlRemove();
    super.initState();
  }

  vartionFun() async {
    // print(
    //     "================================================================================================================================================================================");
    // print(widget.prodNumber["id"]);

    dynamic data = await prodVerResp.prodVaritionResp(
        productId: widget.prodNumber["id"].toString());

    setState(() {
      varitonData = data;
    });
    // print(data);
  }

  String? htmlData;
  htmlRemove() {
    var doc = parse(widget.prodNumber['short_description']);
    if (doc.documentElement != null) {
      String parsedstring = doc.documentElement!.text;
      // print("  html data =========== $parsedstring");
      setState(() {
        htmlData = parsedstring;
      });
      //output without space: HelloThis is fluttercampus.com,Bye!
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Product Details',
        centerTitle: true,
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ! Image Section
                    heightSizedBox(25.0),
                    Container(
                      alignment: Alignment.center,
                      // color: Colors.red,
                      child: Pics(
                        networkImg: true,
                        src:
                            '${widget.prodNumber["images"].length > 0 ? widget.prodNumber["images"][0]['src'] : ''}',
                        // src: 'assets/images/Wooden-Pooja-Mandir.png',
                        width: 300,
                        height: 250,
                      ),
                    ),
                    heightSizedBox(10.0),
                    //  Image List Section
                    // Container(
                    //     child: widget.prodNumber["images"].length > 0
                    //         ? ImgHorizontalList(
                    //             cheight: 80,
                    //             prodList: widget.prodNumber["images"],
                    //             callBack: imgcallBack,
                    //             itemBorder: listImgSrc != null
                    //                 ? listImgSrc.toString()
                    //                 : null,
                    //           )
                    //         : null),
                    // !  Product Content
                    ProdDetailsContent(prodNumber: widget.prodNumber),

                    // Container(
                    //   height: 30,
                    //   child: ListView.builder(
                    //       itemCount: varitonData.length,
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (context, i) {
                    //         return Btn(
                    //           margin: EdgeInsets.all(5),
                    //           onTap: () {

                    //           },
                    //           alignment: Alignment.bottomLeft,
                    //           height: 25,
                    //           // width: 0,
                    //           btnName: '${varitonData[i]["attributes"][0]["option"]}',
                    //           txtColor: offWhiteColor,
                    //           color: offgreenColor,
                    //         );
                    //       }),
                    // ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Txt(
                          t: htmlData.toString(),
                          style: smallTextStyle,
                        ),
                      ),
                    )

                    // ! Btn  for Cart
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Btn(
          onTap: () {
            BlocProvider.of<LocalCartBloc>(context, listen: false)
              ..add(LocalCartItemAddEvent(prodData: {
                "id": widget.prodNumber['id'],
                "name": widget.prodNumber['name'],
                "pic":
                    '${widget.prodNumber["images"].length > 0 ? widget.prodNumber["images"][0]['src'].toString() : ''}',
                "quantity": 1,
                "Fixedsale_price": int.parse(widget.prodNumber["sale_price"]),
                "Fixedregular_price":
                    int.parse(widget.prodNumber["regular_price"]),
                "sale_price": int.parse(widget.prodNumber["sale_price"]),
                "regular_price": int.parse(widget.prodNumber["regular_price"])
              }));
            navigationPush(context, CartScreen());
          },
          alignment: Alignment.bottomLeft,
          height: 45,
          width: double.infinity,
          btnName: 'Add to Cart',
          txtColor: offWhiteColor,
          color: coffeColor,
        ),
      ),
    );
  }
}

class ProdDetailsContent extends StatefulWidget {
  final dynamic prodNumber;
  const ProdDetailsContent({Key? key, this.prodNumber}) : super(key: key);

  @override
  State<ProdDetailsContent> createState() => _ProdDetailsContentState();
}

class _ProdDetailsContentState extends State<ProdDetailsContent> {
  dynamic price;
  dynamic quantity;
  dynamic fullPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [lineLeft(), lineRight()],
          ),
        ],
      ),
    );
  }

  Widget lineLeft() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! Title
        Container(
          margin: EdgeInsets.only(top: 5, left: 10),
          // alignment: Alignment.topLeft,
          child: Txt(
            // t: widget.prodNumber['name'],
            t: '${widget.prodNumber['name'].toString().length >= 20 ? widget.prodNumber['name'].toString().substring(0, 25)
                // + "\n" + widget.prodNumber['name'].toString().substring(40, 80)
                : widget.prodNumber['name']}',
            fontSize: 15,
            style: labelTextStyle,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 5, left: 10),
        //   alignment: Alignment.topLeft,
        //   child: Txt(
        //     // textAlign: TextAlign.left,
        //     t: '${quantity != null ? quantity : 1} KG',
        //     fontSize: 20,
        //     color: greyColor,
        //   ),
        // ),

        // Container(
        //   margin: EdgeInsets.only(top: 5, left: 10),
        //   child: CartBtn(
        //     plusCallBack: plusCallBack,
        //     minusCallBack: minusCallBack,
        //   ),
        // ),
      ],
    );
  }

  Widget lineRight() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 8.0),
      child: Column(
        children: [
          Txt(
            t: 'MRP : Rs${widget.prodNumber["regular_price"]}',
            decoration: TextDecoration.lineThrough,
            fontSize: 13,
            color: greyColor,
          ),
          Txt(
            t: 'Rs ${widget.prodNumber["sale_price"]}',
            fontSize: 17,
            color: offgreenColor,
          ),
        ],
      ),
    );
  }
}
