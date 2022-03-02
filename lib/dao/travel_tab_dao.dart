import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:niu_fluttertrip/model/travel_tab_model.dart';

const TRAVEL_TAB_URL =
    'http://www.devio.org/io/flutter_app/json/travel_page.json';

///旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel?> fetch() async {
    final response = await http.get(Uri.parse(TRAVEL_TAB_URL));
    if (response.statusCode == 200) {
      //success
      Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('Fail to load travel');
    }
  }
}
