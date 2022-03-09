import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niu_fluttertrip/test/test_count.dart';
import 'package:niu_fluttertrip/test/test_full_screen_page.dart';
import 'package:niu_fluttertrip/test/test_futurebuilder.dart';
import 'package:niu_fluttertrip/test/test_http.dart';
import 'package:niu_fluttertrip/test/test_lottie.dart';
import 'package:niu_fluttertrip/test/test_url_launcher.dart';
import 'package:niu_fluttertrip/utils/navigator_util.dart';

/// @author: niumenglin
/// @time: 2022/2/21-5:19 下午
/// @Email: menglin.nml@ncarzone.com
/// @desc:测试页面
class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('测试页'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            _item(
                desc: 'Flutter-Toast提示',
                onClick: () {
                  Fluttertoast.showToast(msg: 'FlutterToast提示');
                }),
            SizedBox(
              height: 30,
            ),
            _item(
                desc: 'Lottie',
                onClick: () {
                  NavigatorUtil.push(context, TestLottiePage());
                }),
            SizedBox(
              height: 30,
            ),
            _item(
                desc: 'http',
                onClick: () {
                  NavigatorUtil.push(context, TestHttp());
                }),
            SizedBox(
              height: 30,
            ),
            _item(
                desc: 'Future与FutureBuilder实用技巧',
                onClick: () {
                  NavigatorUtil.push(context, TestFutureBuilder());
                }),
            SizedBox(
              height: 30,
            ),
            _item(
                desc: '基于shared_preferences实现计数器',
                onClick: () {
                  NavigatorUtil.push(context, TestCountWidget());
                }),
            SizedBox(
              height: 30,
            ),
            _item(
                desc: 'url_launcher',
                onClick: () {
                  NavigatorUtil.push(context, TestUrlLauncher());
                }),
            SizedBox(
              height: 30,
            ),
            _item(
                desc: 'Flutter全面屏适配',
                onClick: () {
                  NavigatorUtil.push(context, TestFullScreenPage());
                }),
          ],
        ),
      ),
    );
  }

  _item({String? desc, Function()? onClick}) {
    return InkWell(
      onTap: onClick,
      child: Text(
        '${desc ?? '未知功能'} >',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
