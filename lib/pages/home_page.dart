import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:niu_fluttertrip/test/test_page.dart';

///首页
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _imageUrls = [
    'https://th.bing.com/th/id/OIP.Qjc-yQWR7Jm4YidbinBGpwHaDH?pid=ImgDet&rs=1',
    'https://th.bing.com/th/id/R.1f7bd7261b0afe549b7d9c0cb14d70f2?rik=u8LaSmLb94pRmQ&pid=ImgRaw&r=0&sres=1&sresct=1',
    'https://th.bing.com/th/id/OIP.P2fBbJvuWdWPkRL-vVxhDAHaDJ?pid=ImgDet&rs=1',
  ];
  double _appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
              removeTop: true, //移除ListView距离顶部的边距Padding
              context: context,
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    //滚动且是列表滚动的时候.  scrollNotification.depth深度设置为0.表示只监测外层的Widget-ListView
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                  return true;
                },
                child: ListView(
                  children: [
                    _buildBanner(),
                    SizedBox(
                      height: 800,
                      child: ListTile(
                        title: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TestPage()));
                          },
                          child: Text('测试页面'),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          _buildMyAppBar(),
        ],
      ),
    );
  }

  ///offset： 滚动的距离
  _onScroll(offset) {
    print(offset);
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
    print('不透明度：$alpha');
  }

  ///构建轮播Widget
  Widget _buildBanner() {
    return SizedBox(
      height: 160,
      child: Swiper(
        itemCount: _imageUrls.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            _imageUrls[index],
            fit: BoxFit.fill,
          );
        },
        pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                space: 5, //点之间的间隔
                size: 10, //未选中时的大小
                activeSize: 12, //选中时的大小
                color: Colors.black54, //未选中时的颜色
                activeColor: Colors.blue)), //指示器
        // control: SwiperControl(color: Colors.white),//页面控制器，左右翻页按钮
        scale: 0.95, //两张图片之间的间隔
      ),
    );
  }

  ///构建自定义AppBarWidget
  Widget _buildMyAppBar() {
    return Opacity(
      opacity: _appBarAlpha, //不透明度
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页'),
          ),
        ),
      ),
    );
  }
}
