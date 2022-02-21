import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @author: niumenglin
/// @time: 2022/2/21-5:31 下午
/// @desc: 基于shared_preferences实现计数器Demo
class TestCountWidget extends StatefulWidget {
  const TestCountWidget({Key? key}) : super(key: key);

  @override
  _TestCountWidgetState createState() => _TestCountWidgetState();
}

class _TestCountWidgetState extends State<TestCountWidget> {
  String countString = '';
  String localCount = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('基于shared_preferences实现计数器'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                  onPressed: _incrementCounter,
                  child: Text('Increment Counter')),
              RaisedButton(onPressed: _getCounter, child: Text('Get Counter')),
              Text(
                countString,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'result：' + localCount,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countString = countString + " 1";
    });
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', counter);
  }

  _getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = prefs.getInt('counter').toString();
    });
  }
}
