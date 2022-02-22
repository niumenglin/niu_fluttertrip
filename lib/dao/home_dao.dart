import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:niu_fluttertrip/model/home_model.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

///首页大接口
class HomeDao {
  static Future<HomeModel?> fetch() async {
    final response = await http.get(Uri.parse(HOME_URL));
    if (response.statusCode == 200) {
      //success
      Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Fail to load home_page.json');
    }
  }
}
