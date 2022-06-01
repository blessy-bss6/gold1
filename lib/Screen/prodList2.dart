import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Backend/Bloc/localCart_Bloc.dart';
import '../Backend/Bloc/prod_Bloc.dart';

import '../Elements/baseAppbar.dart';
import '../Elements/button.dart';

import '../utils/common.dart';
import '../utils/style.dart';
import 'ProdDetails.dart';
import 'cartScr.dart';

class ProductShowScreen extends StatefulWidget {
  ProductShowScreen({Key? key}) : super(key: key);

  @override
  State<ProductShowScreen> createState() => _ProductShowScreenState();
}

class _ProductShowScreenState extends State<ProductShowScreen> {
  ProductBloc prodBloc = ProductBloc();

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProductBloc>(context, listen: false);
    prodBloc.add(FetchProdEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            // print(state);
            if (state is ProdSuccessState) {
              return CustomScrollView(
                slivers: [
                  SliverAppBars(
                    elevation: 4,
                    title: 'Product List',
                  ),

                  //  ! SLIVER PRODUCT CONTENT
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, i) {
                    return InkWell(
                        onTap: () => navigationPush(context,
                            ProdDetailScreen(prodNumber: state.data[i])),
                        child: CheckProd1(
                          prodNumber: state.data[i],
                          // cartData: state.cartData["data"],
                        ));
                  }, childCount: state.data.length))
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

// 1 Product
class CheckProd1 extends StatefulWidget {
  final dynamic prodNumber;
  final List? cartData;
  CheckProd1({Key? key, this.prodNumber, this.cartData}) : super(key: key);

  @override
  State<CheckProd1> createState() => _CheckProd1State();
}

class _CheckProd1State extends State<CheckProd1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: Color.fromARGB(255, 221, 214, 214))),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5.0),
              child: Image.network(
                '${widget.prodNumber["images"].length > 0 ? widget.prodNumber["images"][0]['src'] : ''}',
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                // padding: EdgeInsets.all(2),
              )),
          Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: ProdMidContent(
              prodNumber: widget.prodNumber,
            ),
          ),
          // Container(
          //     child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //       heightSizedBox(20.0),
          //       InkWell(
          //           onTap: () {
          //             BlocProvider.of<LocalCartBloc>(context, listen: false)
          //               ..add(LocalCartItemAddEvent(prodData: {
          //                 "id": widget.prodNumber['id'],
          //                 "name": widget.prodNumber['name'],
          //                 "pic":
          //                     '${widget.prodNumber["images"].length > 0 ? widget.prodNumber["images"][0]['src'].toString() : ''}',
          //                 "quantity": 1,
          //                 "Fixedsale_price":
          //                     int.parse(widget.prodNumber["sale_price"]),
          //                 "Fixedregular_price":
          //                     int.parse(widget.prodNumber["regular_price"]),
          //                 "sale_price":
          //                     int.parse(widget.prodNumber["sale_price"]),
          //                 "regular_price":
          //                     int.parse(widget.prodNumber["regular_price"])
          //               }));
          //             navigationPush(context, CartScreen());
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.all(20),
          //             child: Btn(
          //               width: 50,
          //               padding: EdgeInsets.all(3),
          //               btnName: 'Add',
          //               style: TextStyle(color: txtWhiteColor, fontSize: 10),
          //               // txtColor: offWhiteColor,
          //               color: Colors.green,
          //             ),
          //           ))
          //     ]))
        ],
      ),
    );
  }
}

// ! Product Mid Cotent
class ProdMidContent extends StatelessWidget {
  final dynamic prodNumber;
  final bool? wishList;
  final bool? stock;

  const ProdMidContent(
      {Key? key, this.prodNumber, this.wishList = false, this.stock = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     Txt(
        //       t: '4.6',
        //       fontSize: 13,
        //       color: greyColor,
        //     ),
        //     ImgIcon(
        //       src: 'assets/icons/Star-icon.png',
        //       width: 10,
        //       height: 10,
        //     )
        //   ],
        // ),

        // ! Title
        Container(
          child: Txt(
            t: '${prodNumber['name'].toString().substring(0, 15)}',
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Container(
        //   alignment: Alignment.topLeft,
        //   child: Txt(
        //     t: stock == true
        //         ? 'stock ${prodNumber['stock'].toString()}'
        //         : 'Quantity ${prodNumber['quantity'] ?? 1} KG',
        //     fontSize: 13,
        //     color: greyColor,
        //   ),
        // ),

        Container(
          alignment: Alignment.topLeft,
          child: Txt(
            t: 'MRP:-${prodNumber["regular_price"] }',
            fontSize: 13,
            decoration: TextDecoration.lineThrough,
            color: greyColor,
          ),
        ),

        Container(
          alignment: Alignment.topLeft,
          child: Txt(
            t: 'Rs ${prodNumber["sale_price"]}',
            fontSize: 13,
            style: labelTextStyle,
            color: greyColor,
          ),
        ),

        InkWell(
            onTap: () {
              BlocProvider.of<LocalCartBloc>(context, listen: false)
                ..add(LocalCartItemAddEvent(prodData: {
                  "id": prodNumber['id'],
                  "name": prodNumber['name'],
                  "pic":
                      '${prodNumber["images"].length > 0 ? prodNumber["images"][0]['src'].toString() : ''}',
                  "quantity": 1,
                  "Fixedsale_price": int.parse(prodNumber["sale_price"]),
                  "Fixedregular_price": int.parse(prodNumber["regular_price"]),
                  "sale_price": int.parse(prodNumber["sale_price"]),
                  "regular_price": int.parse(prodNumber["regular_price"])
                }));
              navigationPush(context, CartScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Btn(
                width: 50,
                padding: EdgeInsets.all(3),
                btnName: 'Add',
                style: TextStyle(color: txtWhiteColor, fontSize: 10),
                // txtColor: offWhiteColor,
                color:coffeColor,
              ),
            ))
      ],
    );
  }
}
