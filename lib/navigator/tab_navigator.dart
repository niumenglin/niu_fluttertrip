import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/pages/home_page.dart';
import 'package:niu_fluttertrip/pages/my_page.dart';
import 'package:niu_fluttertrip/pages/search_page.dart';
import 'package:niu_fluttertrip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
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
