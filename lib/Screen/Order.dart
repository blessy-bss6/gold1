import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Backend/Bloc/order_Bloc.dart';
import '../Backend/Resp/orderResp.dart';
import '../Elements/baseAppbar.dart';
import '../Elements/button.dart';
import '../Elements/imgScr.dart';
import '../common/order_cart_item.dart';
import '../utils/common.dart';
import '../utils/style.dart';

import '../Backend/Bloc/reg_Login_Bloc.dart';
import '../utils/shared_helper.dart';
import 'OrderSuccess.dart';

class OrderScreen extends StatefulWidget {
  final dynamic billing;
  final dynamic shipping;
  final dynamic description;
  final bool? isLogin;
  final String? password;
  final dynamic userId;
  final dynamic subPrice;
  OrderScreen(
      {Key? key,
      this.billing,
      this.shipping,
      this.password,
      this.description,
      this.userId,
      this.subPrice,
      this.isLogin})
      : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  dynamic priceData = 0;
  dynamic bottomBtn = true;
  dynamic cartData;
  ShopC shoping = ShopC();
  OrderRespo orderResp = OrderRespo();
  OrderBloc orderB = OrderBloc();
  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    priceData = shoping.refreshItems();
    orderB = BlocProvider.of<OrderBloc>(context, listen: false);
    orderB.add(FetchOrderEvent());

    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (widget.billing != null) {
      BlocProvider.of<OrderBloc>(context, listen: false)
        ..add(OrderItemAddEvent(
            userId: widget.userId,
            orderData: priceData['orderData'],
            billing: widget.billing,
            shipping: widget.shipping,
            transcationId: response.paymentId,
            payMode: response.signature,
            // ammount: priceData['subPrice'] + priceData['shipPrice'],

            context: context));
      setState(() {
        bottomBtn = false;
      });
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    snackBar(context, 'Error Payment Not Successs', bgColor: redColor);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_Bsl88j2I6mxRJt',
      'amount': ' ${(priceData['subPrice'] + priceData['shipPrice']) * 100}',
      'name': '',
      'description': '',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      "currency": "INR",
      'prefill': {
        'contact': '${widget.billing['phone']}',
        'email': '${widget.billing['email']}'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  dynamic loadMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OrderBloc, OrderState>(listener: (context, state) {
        if (state is OrderCompleteState) {
          if (widget.isLogin == false) {
            BlocProvider.of<AuthBloc>(context, listen: false)
              ..add(SignUpBtnEvent(
                  email: widget.billing['email'],
                  password: widget.password,
                  username: widget.billing['email']));
            navigationPush(
                context,
                OrderCompleteScreen(
                    orderId: state.data['id'],
                    transcationId: "${state.data['transaction_id']}",
                    ammount: state.data['total']));
          } else {
            // navigationPush(context, OrderCompleteScreen());

            navigationPush(
                context,
                OrderCompleteScreen(
                    orderId: state.data['id'],
                    transcationId: "${state.data['transaction_id']}",
                    ammount: state.data['total']));
          }
        }
      }, builder: (context, state) {
        if (state is OrderSuccessState) {
          return state.data.isNotEmpty
              ? CustomScrollView(
                  slivers: [
                    SliverAppBars(
                      title: 'Order Screen',
                    ),

                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: borderColor)),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Pics(
                                  networkImg: true,
                                  src: state.data[i]['pic'],
                                  width: 120,
                                  height: 100,
                                ),
                                BasicProdDetail(
                                  prodNumber: state.data[i],
                                ),
                              ],
                            ),
                          ),
                        ),
                        childCount: state.data.length,
                      ),
                    )

                    //  ! Sliver Product Content
                  ],
                )
              : CustomScrollView(slivers: [
                  // ! Sliver app Bar

                  SliverAppBars(
                    title: 'Order Screen',
                  ),
                  SliverToBoxAdapter(
                      child: Center(
                    child: Text('No Data'),
                  )),
                ]);
        } else {
          Timer(
              Duration(seconds: 3),
              () => setState(() {
                    loadMore = false;
                  }));
          return loadMore == false
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Text('No Data'),
                );
        }
      }),
      // ),
      bottomNavigationBar: bottomBtn == false
          ? null
          : Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                height: 180,
                child: Column(
                  children: [
                    // Expanded(child: Container(child: PriceList())),
                    PriceList(
                      // prodNumber: priceData,
                      shipPrice: priceData['shipPrice'],
                      mrpPrice: priceData['mrpPrice'],
                      subPrice: priceData['subPrice'],
                    ),
                    Btn(
                        height: 35,
                        width: double.infinity,
                        btnName: 'Order',
                        txtColor: txtWhiteColor,
                        color: coffeColor,
                        onTap: () {
                          openCheckout();

                          // if (widget.billing != null) {
                          //   BlocProvider.of<OrderBloc>(context, listen: false)
                          //     ..add(OrderItemAddEvent(
                          //         userId: widget.userId,
                          //         orderData: priceData['orderData'],
                          //         billing: widget.billing,
                          //         shipping: widget.shipping,
                          //         context: context));
                          //   setState(() {
                          //     bottomBtn = false;
                          //   });
                          // }
                        }),
                  ],
                ),
              )),
    );
  }
}

class ExtraBodyContent extends StatelessWidget {
  const ExtraBodyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // ! Sliver app Bar

        SliverAppBars(
          title: 'Order Screen',
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Txt(
                  t: 'Delivery Address',
                  style: labelTextStyle,
                ),
                OrderIdAdrContent(
                  t2: 'batla House, Sikar,jaipur ',
                ),
              ],
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int i) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: borderColor)),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Pics(
                      src: 'assets/images/indianGod.png',
                      width: 120,
                      height: 100,
                    ),
                    BasicProdDetail(cartBtn: false),
                  ],
                ),
              ),
            ),
            childCount: 5,
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            children: [Divider(), PriceList()],
          ),
        ),

        //  ! Sliver Product Content
      ],
    );
  }
}
