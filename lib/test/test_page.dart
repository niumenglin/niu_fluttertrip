import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/test/test_count.dart';
import 'package:niu_fluttertrip/test/test_futurebuilder.dart';
import 'package:niu_fluttertrip/test/test_http.dart';

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
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TestHttp()));
              },
              child: Text(
                'http >',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestFutureBuilder()));
              },
              child: Text(
                'Future与FutureBuilder实用技巧 >',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TestCountWidget()));
              },
              child: Text(
                '基于shared_preferences实现计数器 >',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
