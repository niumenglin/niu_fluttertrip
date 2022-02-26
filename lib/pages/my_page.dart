import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/widgets/webview.dart';

///我的
const String _url = 'https://m.ctrip.com/webapp/myctrip/';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        url: _url,
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      ),
    );
  }
}
