import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:niu_fluttertrip/pages/home_page.dart';
import 'package:niu_fluttertrip/pages/my_page.dart';
import 'package:niu_fluttertrip/pages/search_page.dart';
import 'package:niu_fluttertrip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);
  DateTime? _lastClickTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_lastClickTime == null ||
            DateTime.now().difference(_lastClickTime!) >
                const Duration(seconds: 1)) {
          //两次点击时间间隔超过1秒则重新计时
          _lastClickTime = DateTime.now();
          Fluttertoast.showToast(
              msg: "再按一次退出APP",
              textColor: Colors.white,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black54);
          return Future.value(false); //不消费
        }
        Fluttertoast.cancel();
        return Future.value(true);
      },
      child: Scaffold(
        //用WillPopScope组件把你的页面body部分包起来，它可以拦截返回键按钮进行误触判断
        body: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(), //禁止左右滑动
          onPageChanged: (int index) {
            print('当前页面下标是：$index');
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            HomePage(),
            SearchPage(),
            TravelPage(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomNavigationBarItem(Icons.home, '首页', 0),
            _bottomNavigationBarItem(Icons.search, '搜索', 1),
            _bottomNavigationBarItem(Icons.camera_alt, '旅拍', 2),
            _bottomNavigationBarItem(Icons.account_circle, '我的', 3),
          ],
        ),
      ),
    );
  }

  ///底部导航栏
  _bottomNavigationBarItem(IconData? icon, String navLabel, int position) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          navLabel,
          style: TextStyle(
              fontFamily: 'MaShanZheng', //局部widget使用自定义字体
              fontSize: 14,
              color: _currentIndex != position ? _defaultColor : _activeColor),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
