import 'dart:convert';

import 'package:dio/dio.dart';

class PaymentResp {
  var auth = 'Basic ' +
      base64Encode(
          utf8.encode('rzp_test_Bsl88j2I6mxRJt:Kra6tYBspAp3Qio0LMTJOoCJ'));

  Future<dynamic> paymentCapturedResp({
    dynamic ammount,
    dynamic transcationId,
  }) async {
    try {
      int totalAmmount = ammount.round() * 100;

      Response response = await Dio().post(
        'https://api.razorpay.com/v1/payments/$transcationId/capture',
        data: {"amount": totalAmmount},
        options: Options(headers: {
          'authorization': auth,
          "Content-Type": "application/json"
        }),
      );

      // print(response);
    } on DioError catch (e) {
      // print(e);
    }
  }

//  1 Refund Payment
  Future<dynamic> paymentRefundResp({
    dynamic ammount,
    dynamic transcationId,
  }) async {
    try {
      int totalAmmount = ammount.round() * 100;

      Response response = await Dio().post(
          'https://api.razorpay.com/v1/payments/$transcationId/refund',
          data: {"amount": totalAmmount},
          options: Options(headers: <String, String>{
            'authorization': auth,
            "Content-Type": "application/json"
          }));

      // print(response);
    } on DioError catch (e) {
      // print(e);
      print(e.response!.data);
    }
  }
}
