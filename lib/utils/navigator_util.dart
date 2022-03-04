import 'package:flutter/material.dart';

/// @author: niumenglin
/// @time: 2022/3/4-2:13 下午
/// @desc:路由工具类
class NavigatorUtil {
  ///退出页面
  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  ///跳转到指定页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
