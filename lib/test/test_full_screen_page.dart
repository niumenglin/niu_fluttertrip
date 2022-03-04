import 'package:flutter/material.dart';

/// @author: niumenglin
/// @time: 2022/3/3-11:09 下午
/// @desc:全面屏幕适配（2种方式，Android需要单独配置<meta-data androiod:name="android.max_aspect" android:value="2.1"/>）
class TestFullScreenPage extends StatefulWidget {
  const TestFullScreenPage({Key? key}) : super(key: key);

  @override
  _TestFullScreenPageState createState() => _TestFullScreenPageState();
}

class _TestFullScreenPageState extends State<TestFullScreenPage> {
  // ///方案1：全面屏适配-SafeArea
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: '全面屏适配-SafeArea',
  //     theme: ThemeData(primarySwatch: Colors.blue),
  //     home: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //       ),
  //       child: SafeArea(
  //           child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text('顶部'),
  //           Text('底部'),
  //         ],
  //       )),
  //     ),
  //   );
  // }

  ///方案2：全面屏适配-MediaQuery.of(context).padding  更加灵活
  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Container(
      padding: EdgeInsets.fromLTRB(0, padding.top, 0, padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('顶部'),
          Text('底部'),
        ],
      ),
    );
  }
}
