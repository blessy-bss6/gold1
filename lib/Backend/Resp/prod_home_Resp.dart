import '/utils/app_constants.dart';
import '/utils/http_services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ProdHomeRespo {
  Future<dynamic> prodResp() async {
    String url = URLConstants.baseUrl +
        URLConstants.productUrl + "?per_page=100"+
        "&consumer_key=${URLConstants.Key}&consumer_secret=${URLConstants.password}";

    final response = await http.get(Uri.parse(url));
    // print(response.statusCode);

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      // print(data);

      return data;
    } else {
      return false;
    }
  }

  Future<dynamic> subprodResp({String? pageNum, String? categoryId}) async {
    String url = URLConstants.baseUrl +
        URLConstants.productUrl +
        "?per_page=$pageNum&category=$categoryId"
            "&consumer_key=${URLConstants.Key}&consumer_secret=${URLConstants.password}";

    final response = await getDioRequest(url);
    // print(response);
    if (response != null) {
      return response;
    } else {
      // print(response);
      // return response;
      return false;
    }
  }

  Future<dynamic> prodVaritionResp(
      { String? productId}) async {
    String url = URLConstants.baseUrl +"/wp-json/wc/v3/products/$productId/variations"+"?consumer_key=${URLConstants.Key}&consumer_secret=${URLConstants.password}";
    // https: //liveprojects.co.in/goldgift/wp-json/wc/v3/products/118464/variations?consumer_key=ck_e574cd75f0fedf68fda0fa8fd99c17f54665a4c6&consumer_secret=cs_9e084118b1fdba78c85c24b6a209fdf382057e5e
    final response = await getDioRequest(url);
    // print(response);
    if (response != null) {
      return response;
    } else {
      // print(response);
      // return response;
      return false;
    }
  }
}
