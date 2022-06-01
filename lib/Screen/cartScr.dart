import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Elements/baseAppbar.dart';
import '../Elements/button.dart';
import '../Elements/imgScr.dart';
import '../common/order_cart_item.dart';
import '../utils/common.dart';
import '../utils/style.dart';
import '../Backend/Bloc/localCart_Bloc.dart';
import 'CheckOutScr.dart';
import 'a.dart';
import 'bottomNav.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  dynamic priceData = 0;
  dynamic bottomBtn = false;
  dynamic cartData;
  dynamic appBarBtn = false;

  dynamic loadMore = true;
  LocalCartBloc localcartB = LocalCartBloc();

  @override
  void initState() {
    // TODO: implement initState
    localcartB = BlocProvider.of<LocalCartBloc>(context, listen: false);
    localcartB.add(FetchLocalCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () => willPopCallback(context, true,
          widget: UserNavigationBar(currentTab: 0)),
      child: Scaffold(
        body: BlocConsumer<LocalCartBloc, LocalCartState>(
            listener: (context, state) {
          if (state is LocalCartSuccessState) {
            if (state.data.length > 0) {
              // print(state.data);
              setState(() {
                cartData = state.data;
                priceData = state.priceData;
                // shipPrice = state.priceData!['shipPrice'];
                // mrpPrice = state.priceData!['mrpPrice'];
                // subPrice = state.priceData!['subPrice'];
                bottomBtn = true;
              });
            } else {
              setState(() {
                priceData = 0;
                bottomBtn = false;
              });
            }
          }
        }, builder: (context, state) {
          if (state is LocalCartSuccessState) {
            return state.data.length > 0
                ? CustomScrollView(
                    slivers: [
                      // ! Sliver app Bar
    
                      SliverAppBars(
                          title: 'Cart Screen',
                          leading: new IconButton(
                              icon: new Icon(Icons.arrow_back),
                              onPressed: () => navigationPushReplacement(
                                    context,
                                    widget: UserNavigationBar(
                                      currentTab: 0,
                                    ),
                                  ))),
    
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int i) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: borderColor)),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Pics(
                                      networkImg: true,
                                      src: '${state.data[i]["pic"]}',
                                      width: 120,
                                      height: 100,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BasicProdDetail(
                                          prodNumber: state.data[i],
                                        ),
                                        CartButn(
                                          prodNumber: state.data[i],
                                          pic: state.data[i]['pic'],
                                        ),
                                        SizedBox(height: 10.0),
                                      ],
                                    ),
                                    IconBtn(
                                        icon: Icons.delete,
                                        size: 20,
                                        onPressed: () {
                                          // shoping.deleteItem(currentItem['key']),
                                          BlocProvider.of<LocalCartBloc>(context,
                                              listen: false)
                                            ..add(LocalCartItemDelEvent(
                                                id: state.data[i]['key']));
                                        })
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: state.data.length,
                        ),
                      ),
                    ],
                  )
                : CustomScrollView(slivers: [
                    // ! Sliver app Bar
    
                    SliverAppBars(
                        title: 'Cart Screen',
                        leading: new IconButton(
                            icon: new Icon(Icons.arrow_back),
                            onPressed: () => navigationPushReplacement(
                                  context,
                                  widget: UserNavigationBar(
                                    currentTab: 0,
                                  ),
                                ))),
    
                    SliverToBoxAdapter(
                        child: Center(
                      child: Text('No Data'),
                    )),
                  ]);
          } else {
            return CustomScrollView(slivers: [
              //     // ! Sliver app Bar
    
              SliverAppBars(
                title: 'Cart Screen',
                
              ),
              SliverToBoxAdapter(
                  child: Center(
                child: Text('No Data'),
              )),
            ]);
            // return Center(
            //   child: CircularProgressIndicator(),
            // );
          }
        }),
        // ),
        bottomNavigationBar: Container(
          height: 200,
          child: bottomBtn == true
              ? Column(
                  children: [
                    Divider(),
                    PriceList(
                      // prodNumber: priceData,
                      shipPrice: priceData['shipPrice'],
                      mrpPrice: priceData['mrpPrice'],
                      subPrice: priceData['subPrice'],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 9.0, 20.0, 5.0),
                      child: Btn(
                        height: 35,
                        width: double.infinity,
                        btnName: 'CheckOut',
                        txtColor: txtWhiteColor,
                        color: coffeColor,
                        onTap: () => navigationPush(context, CheckOutScreen()),
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}

// !
class CartButn extends StatelessWidget {
  final dynamic prodNumber;
  dynamic pic;
  dynamic onPressed;

  CartButn({
    Key? key,
    this.prodNumber,
    this.onPressed,
    this.pic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('produNuber $prodNumber');
    // print('produNuber ${}');
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
                // color: color,
                // onPressed: onPressed,
                onPressed: prodNumber['quantity'] > 1
                    ? () {
                        BlocProvider.of<LocalCartBloc>(context, listen: false)
                          ..add(LocalCartItemPutEvent(
                              id: prodNumber['key'],
                              prodData: {
                                "id": prodNumber["id"],
                                "name": prodNumber['name'],
                                "pic": pic,
                                "quantity": prodNumber['quantity'] - 1,
                                "Fixedsale_price":
                                    prodNumber['Fixedsale_price'],
                                "Fixedregular_price":
                                    prodNumber['Fixedregular_price'],
                                "sale_price": prodNumber['Fixedsale_price'] *
                                    (prodNumber['quantity'] - 1),
                                "regular_price":
                                    prodNumber['Fixedregular_price'] *
                                        (prodNumber['quantity'] - 1)
                              }));
                      }
                    : null,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '${prodNumber['quantity']}',
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
                  // color: color,
                  onPressed: () {
                    BlocProvider.of<LocalCartBloc>(context, listen: false)
                      ..add(LocalCartItemPutEvent(
                          id: prodNumber['key'],
                          prodData: {
                            "id": prodNumber["id"],
                            "name": prodNumber['name'],
                            "pic": pic,
                            "quantity": prodNumber['quantity'] + 1,
                            "Fixedsale_price": prodNumber['Fixedsale_price'],
                            "Fixedregular_price":
                                prodNumber['Fixedregular_price'],
                            "sale_price": prodNumber['Fixedsale_price'] *
                                (prodNumber['quantity'] + 1),
                            "regular_price": prodNumber['Fixedregular_price'] *
                                (prodNumber['quantity'] + 1)
                          }));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
