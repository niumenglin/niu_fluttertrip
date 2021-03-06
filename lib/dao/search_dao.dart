import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:niu_fluttertrip/model/home_model.dart';
import 'package:niu_fluttertrip/model/search_model.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

///搜索接口
class SearchDao {
  static Future<SearchModel?> fetch(String keyWord) async {
    final response = await http.get(Uri.parse('$SEARCH_URL$keyWord'));
    if (response.statusCode == 200) {
      //success
      Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return SearchModel.fromJson(result);
    } else {
      throw Exception('Fail to search');
    }
  }

  static Future<SearchModel?> fetch2(String url, String text) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //success
      Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      //只有当前输入的内容和服务器端返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    } else {
      throw Exception('Fail to search');
    }
  }
}
