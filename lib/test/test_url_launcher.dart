import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// @author: niumenglin
/// @time: 2022/2/26-6:34 下午
/// @desc:测试启动URL插件
const String _url =
    'https://hotels.ctrip.com/?sid=167068&allianceid=5376&qhclickid=96517afd2a8b6ad8&keywordid=3483233637';

class TestUrlLauncher extends StatefulWidget {
  const TestUrlLauncher({Key? key}) : super(key: key);

  @override
  _TestUrlLauncherState createState() => _TestUrlLauncherState();
}

class _TestUrlLauncherState extends State<TestUrlLauncher> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('启动URL url_launcher'),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: _launchURL,
              child: Text(
                'Show ctrip homepage',
                style: TextStyle(fontSize: 26),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
