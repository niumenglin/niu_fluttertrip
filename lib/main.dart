import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:niu_fluttertrip/navigator/tab_navigator.dart';

void main() {
  setSystemUIOverlayStyle();
  runApp(const MyApp());
}

void setSystemUIOverlayStyle() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        ///这是设置状态栏的图标和字体的颜色
        ///Brightness.light  一般都是显示为白色;Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '牛拍',
      theme: ThemeData(
        // fontFamily: 'MaShanZheng',//将字体应用到全局
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
              //也可以使用如下方式隐藏键盘
              // SystemChannels.textInput.invokeMethod('TextInput.hide');
            }
          },
          child: child,
        ),
      ),
      home: TabNavigator(),
    );
  }
}
