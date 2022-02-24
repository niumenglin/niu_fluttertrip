import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:niu_fluttertrip/dao/home_dao.dart';
import 'package:niu_fluttertrip/model/common_model.dart';
import 'package:niu_fluttertrip/model/gird_nav_model.dart';
import 'package:niu_fluttertrip/model/home_model.dart';
import 'package:niu_fluttertrip/model/sales_box_model.dart';
import 'package:niu_fluttertrip/widgets/grid_nav.dart';
import 'package:niu_fluttertrip/widgets/loading_container.dart';
import 'package:niu_fluttertrip/widgets/local_nav.dart';
import 'package:niu_fluttertrip/widgets/sales_box.dart';
import 'package:niu_fluttertrip/widgets/search_bar.dart';
import 'package:niu_fluttertrip/widgets/sub_nav.dart';
import 'package:niu_fluttertrip/widgets/webview.dart';

///首页
const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
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
  bool _loading = true; //加载状态，默认初始化时=true 即加载中

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel? model = await HomeDao.fetch();
      setState(() {
        bannerList = model?.bannerList ?? [];
        localNavList = model?.localNavList ?? [];
        gridNavModel = model!.gridNav;
        subNavList = model.subNavList ?? [];
        salesBoxModel = model.salesBox;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('首页----build');
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true, //移除ListView距离顶部的边距Padding
              context: context,
              child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: NotificationListener(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0) {
                        //滚动且是列表滚动的时候.  scrollNotification.depth深度设置为0.表示只监测外层的Widget-ListView
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                      return false;
                    },
                    child: _listView,
                  )),
            ),
            _appBar,
          ],
        ),
      ),
    );
  }

  ///构建ListView
  Widget get _listView {
    return ListView(
      children: [
        _banner,
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
      ],
    );
  }

  ///构建自定义AppBar
  Widget get _appBar {
    // return Opacity(
    //   opacity: _appBarAlpha, //不透明度
    //   child: Container(
    //     height: 80,
    //     decoration: const BoxDecoration(color: Colors.white),
    //     child: const Center(
    //       child: Padding(
    //         padding: EdgeInsets.only(top: 20),
    //         child: Text('首页'),
    //       ),
    //     ),
    //   ),
    // );
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0x66000000), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(_appBarAlpha.toInt() * 255, 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: _appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakButtonClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
          height: _appBarAlpha > 0.2 ? 05 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  ///构建Banner轮播图
  Widget get _banner {
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

  //跳转至搜索页
  _jumpToSearch() {}

  //跳转语音页
  _jumpToSpeak() {}
}
