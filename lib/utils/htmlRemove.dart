import 'package:html/parser.dart';

class HtmlTags {
  static removeTag({htmlString, callBack}) {
    var document = parse(htmlString);
    String parsedString = parse(document.body!.text).documentElement!.text;
    callBack(parsedString);
  }
}
