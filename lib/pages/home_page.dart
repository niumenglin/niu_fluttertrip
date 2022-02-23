import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:niu_fluttertrip/dao/home_dao.dart';
import 'package:niu_fluttertrip/model/common_model.dart';
import 'package:niu_fluttertrip/model/gird_nav_model.dart';
import 'package:niu_fluttertrip/model/home_model.dart';
import 'package:niu_fluttertrip/model/sales_box_model.dart';
import 'package:niu_fluttertrip/test/test_page.dart';
import 'package:niu_fluttertrip/widgets/grid_nav.dart';
import 'package:niu_fluttertrip/widgets/local_nav.dart';
import 'package:niu_fluttertrip/widgets/sales_box.dart';
import 'package:niu_fluttertrip/widgets/sub_nav.dart';
import 'package:niu_fluttertrip/widgets/webview.dart';

///首页
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel? gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel? salesBoxModel;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    try {
      HomeModel? model = await HomeDao.fetch();
      setState(() {
        bannerList = model?.bannerList ?? [];
        localNavList = model?.localNavList ?? [];
        gridNavModel = model!.gridNav;
        subNavList = model.subNavList ?? [];
        salesBoxModel = model.salesBox;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child: LocalNav(localNavList: localNavList),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: GridNav(
                        gridNavModel: gridNavModel,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: SubNav(
                        subNavList: subNavList,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                      child: SalesBox(
                        salesBox: salesBoxModel,
                      ),
                    ),
                    SizedBox(
                      height: 800,
                      child: ListTile(
                        title: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TestPage()));
                          },
                          child: const Text('测试页面'),
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
        itemCount: bannerList.length,
        autoplay: true,
        onTap: (int index) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: bannerList[index].url!,
                      )));
        },
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            bannerList[index].icon!,
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
        decoration: const BoxDecoration(color: Colors.white),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页'),
          ),
        ),
      ),
    );
  }
}
