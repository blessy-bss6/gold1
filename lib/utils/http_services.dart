import 'package:dio/dio.dart';

// ValueNotifier<User> currentUser = ValueNotifier(User());
// ! Get Resuest
Future getDioRequest(String url) async {
  Map<String, dynamic> header = Map<String, dynamic>();
  // header['Authorization'] = "Bearer " + currentUser.value.token!;
  header['Content-Type'] = 'application/json';

  try {
    Response response = await Dio().get(url, options: Options(headers: header));
    if (response.statusCode == 200) {
      return response.data;
    }
    // return false;
  } on DioError catch (e) {
    return e.response!.data;
  }
}

// ! Post Reauest
Future postDioRequest(String url,
    {dynamic data,
    Map<String, dynamic>? newheaders,
    String? header,
    String? contentType}) async {
  Response response;
  Dio dio = Dio();
  // print('URL ' + url);
  // print('Input ' + data.toString());
  Map<String, dynamic> headers = Map<String, dynamic>();
  // header != null
  //     ? headers['GoogleAccessToken'] = header
  //     // : headers['authorization'] = "Bearer " + currentUser.value.token!;
  // headers['Content-Type'] =
  //     contentType != null ? contentType : 'application/json';
  // print('Header' + headers.toString());
  try {
    response = await dio.post(
      url,
      data: data,
    );
  } on DioError catch (e) {
    // print('Response' + e.response!.data.toString());
    return e.response!.data;
  }
  print('Response ' + response.data.toString());
  print('Response ' + response.statusCode.toString());
  return response.data;
}

// ! PUT request
Future putDioRequest(String url, var body, {String? header}) async {
  Response response;
  Map<String, dynamic> headers = Map<String, dynamic>();
  // header != null
  //     ? headers['GoogleAccessToken'] = header
  //     // : headers['authorization'] = "Bearer " + currentUser.value.token!;
  // headers['Content-Type'] = 'application/json';

  // print('URL ' + url);
  // print('Input ' + body.toString());
  try {
    response =
        await Dio().put(url, data: body, options: Options(headers: headers));
  } on DioError catch (e) {
    // print('Response' + e.response!.statusCode.toString());
    // print('Response' + e.response!.data.toString());
    return e.response!.data;
  }
  // print('Response' + response.statusCode.toString());
  // print('Response' + response.data.toString());
  return response.data;
}

// ! Delete Request
Future delDioRequest(String url, {Map<String, dynamic>? body}) async {
  Response response;

  print('URL ' + url);
  print('Input ' + body.toString());
  try {
    response = await Dio().put(url, data: body);
  } on DioError catch (e) {
    print('Response' + e.response!.data.toString());
    return e.response!.data;
  }
  print('Response' + response.data.toString());
  return response;
}
