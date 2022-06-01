import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Backend/Bloc/order_Bloc.dart';
import '../Backend/Resp/payment_Resp.dart';
import '../Elements/baseAppbar.dart';
import '../Elements/button.dart';
import '../utils/common.dart';
import '../utils/shared_helper.dart';
import '../utils/style.dart';

import '../Backend/Bloc/reg_Login_Bloc.dart';
import 'bottomNav.dart';

class OrderCompleteScreen extends StatefulWidget {
  final String? email;
  dynamic orderId;
  dynamic transcationId;
  dynamic ammount;
  OrderCompleteScreen(
      {Key? key, this.orderId, this.email, this.ammount, this.transcationId})
      : super(key: key);

  @override
  State<OrderCompleteScreen> createState() => _OrderCompleteScreenState();
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  dynamic userId;
  dynamic isLogin = false;
  SharedHelper sharedHelper = SharedHelper();

  PaymentResp payresp = PaymentResp();
  @override
  void initState() {
    // TODO: implement initState
    _checkLogin();

    super.initState();
  }

  _checkLogin() async {
    bool isUser = await sharedHelper.containsKey('userIdType');
    bool isLog = await sharedHelper.containsKey('current_user');
    dynamic id = await sharedHelper.getUserTypeScr('userIdType');

    setState(() {
      isLogin = isLog;
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: coffeColor,
          centerTitle: true,
          title: Text(
            'Order Complete',
            // style: appBarTS,
            style: TextStyle(color: offWhiteColor),
          ),
          // automaticallyImplyLeading: false,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                if (isLogin == false) {
                  BlocProvider.of<OrderBloc>(context, listen: false)
                    ..add(OrderItemUpdateEvent(
                        customerId: userId,
                        orderId: widget.orderId,
                        context: context));

                  payresp.paymentCapturedResp(
                      transcationId: "${widget.transcationId}",
                      ammount: double.parse(widget.ammount.toString()));

                  navigationPushReplacement(context,
                      widget: UserNavigationBar(
                        currentTab: 0,
                      ));
                } else {
                  payresp.paymentCapturedResp(
                      transcationId: "${widget.transcationId}",
                      ammount: double.parse(widget.ammount));

                  navigationPushReplacement(context,
                      widget: UserNavigationBar(
                        currentTab: 0,
                      ));
                }
              }),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment: ,
          children: [
            Center(
              child: Txt(
                t: 'Your Order has been                               \n        accepted',
                style: labelTextStyle,
              ),
            ),
            heightSizedBox(5.0),
            Center(
              child: Txt(
                t: "Your Items has been placed and is on \n It's way to being processed",
                style: smallTextStyle,
              ),
            ),
            //   InkWell(onTap: () {
            //     BlocProvider.of<AuthBloc>(context, listen: false)
            //         ..add(SignUpBtnEvent(email: email, context: context));
            //   },
            //     child: Container( height: 40,width: 60,child: Text('ok',style: labelTextStyle)))
          ],
        ),
      ),
    );
  }
}
