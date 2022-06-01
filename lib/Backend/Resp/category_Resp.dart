import '/utils/app_constants.dart';
import '/utils/http_services.dart';

class CategoryRespo {
  Future<dynamic> categoryResp({String? pageNum = '1'}) async {
    String url = URLConstants.baseUrl +
        URLConstants.categoryUrl+"?page=$pageNum&per_page=30"
  "&consumer_key=${URLConstants.Key}&consumer_secret=${URLConstants.password}";
    
    final response = await getDioRequest(url);
    // print("response data  $response");
    if (response != null) {
      return response;
    } else {
      // print(response);
      // return response;
      return false;
    }
  }

  Future<dynamic> subCategoryResp({String? pageNum, String ?parent}) async {
    String url = URLConstants.baseUrl +
        URLConstants.categoryUrl + "?page=$pageNum&per_page=30&parent=$parent"
        "&consumer_key=${URLConstants.Key}&consumer_secret=${URLConstants.password}";

    final response = await getDioRequest(url);
    // print(response);
    if (response != null) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }
}
