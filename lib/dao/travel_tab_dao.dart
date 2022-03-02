import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:niu_fluttertrip/model/travel_model.dart';

const TRAVEL_URL = 'http://www.devio.org/io/flutter_app/json/travel_page.json';

///旅拍类别接口
var Params = {
  "districtId": -1,
  "groupChannelCode": "RX-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {},
  "contentType": "json"
};

class TravelTabDao {
  static Future<TravelModel?> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    //动态修改固定参数
    Map paramsMap = Params['pagePara'] as Map;
    paramsMap['groupChannelCode'] = groupChannelCode;
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    final response =
        await http.post(Uri.parse(TRAVEL_URL), body: jsonEncode(Params));
    if (response.statusCode == 200) {
      //success
      Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelModel.fromJson(result);
    } else {
      throw Exception('Fail to load travel');
    }
  }
}
