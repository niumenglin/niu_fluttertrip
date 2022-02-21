import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:niu_fluttertrip/test/test_http.dart';

/// @author: niumenglin
/// @time: 2022/2/21-10:46 上午
/// @desc:测试 FutureBuilder
class TestFutureBuilder extends StatefulWidget {
  const TestFutureBuilder({Key? key}) : super(key: key);

  @override
  _TestFutureBuilderState createState() => _TestFutureBuilderState();
}

class _TestFutureBuilderState extends State<TestFutureBuilder> {
  String _showResult = '';

  static Future<CommonModel> fetchPost() async {
    final response = await http.get(Uri.parse(
        'http://www.devio.org/io/flutter_app/json/test_common_model.json'));
    // final result = json.decode(response.body);
    Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Future与FutureBuilder实用技巧'),
        ),
        body: FutureBuilder<CommonModel>(
            future: fetchPost(),
            builder:
                (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
              //判断网络连接状态
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Input a URL to start');
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return Text('');
                case ConnectionState.done: //网络请求结束
                  if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    //网络请求成功
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('icon: ${snapshot.data!.icon}'),
                          Text(
                              'statusBarColor: ${snapshot.data!.statusBarColor}'),
                          Text('title: ${snapshot.data!.title}'),
                          Text('url: ${snapshot.data!.url}')
                        ]);
                  }
              }
            }),
      ),
    );
  }
}
