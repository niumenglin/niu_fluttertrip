import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

///首页
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
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
            )
          ],
        ),
      ),
    );
  }
}
