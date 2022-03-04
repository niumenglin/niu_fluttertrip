import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:niu_fluttertrip/test/test_futurebuilder.dart';
import 'package:niu_fluttertrip/utils/navigator_util.dart';

/// @author: niumenglin
/// @time: 2022/2/21-10:46 上午
/// @desc:测试Http
class TestHttp extends StatefulWidget {
  const TestHttp({Key? key}) : super(key: key);

  @override
  _TestHttpState createState() => _TestHttpState();
}

class _TestHttpState extends State<TestHttp> {
  String _showResult = '';

  static Future<CommonModel> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://www.devio.org/io/flutter_app/json/test_common_model.json'));
    // final result = json.decode(response.body);
    Utf8Decoder utf8decoder = Utf8Decoder();
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Http'),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                fetchPost().then((CommonModel value) {
                  setState(() {
                    _showResult =
                        '请求结果：\nhideAppBar:${value.hideAppBar}\nicon:${value.icon} ';
                  });
                });
              },
              child: Text(
                '点我',
                style: TextStyle(fontSize: 26),
              ),
            ),
            Text(_showResult),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                NavigatorUtil.push(context, TestFutureBuilder());
              },
              child: Text(
                'Future与FutureBuilder实用技巧',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonModel {
  final String? icon;
  final String? title;
  final String? url;
  final String? statusBarColor;
  final bool? hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
