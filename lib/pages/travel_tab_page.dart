import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/dao/travel_dao.dart';
import 'package:niu_fluttertrip/model/travel_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:niu_fluttertrip/widgets/webview.dart';

///旅拍Tab
const int PAGE_SIZE = 10;
const String TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelTabPage extends StatefulWidget {
  final String? travelUrl;
  final String? groupChannelCode; //频道代码

  const TravelTabPage({Key? key, this.travelUrl, this.groupChannelCode})
      : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;

  // true=当前页面保活（with AutomaticKeepAliveClientMixin）
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    TravelDao.fetch(widget.travelUrl ?? TRAVEL_URL,
            widget.groupChannelCode ?? '', pageIndex, PAGE_SIZE)
        .then((TravelItemModel? model) {
      setState(() {
        List<TravelItem> items = _filterItems(model!.resultList);
        if (travelItems.isEmpty) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: MasonryGridView.count(
            itemCount: travelItems.length,
            // the number of columns 列数
            crossAxisCount: 2,
            // // vertical gap between two items
            // mainAxisSpacing: 4,
            // // horizontal gap between two items
            // crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return ItemTravel(
                index: index,
                item: travelItems[index],
              );
            },
          )),
    );
  }

  List<TravelItem> _filterItems(List<TravelItem>? resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    for (var element in resultList) {
      if (element.article != null) {
        //移除 article 为空的模型
        filterItems.add(element);
      }
    }
    return filterItems;
  }
}

//Item布局
class ItemTravel extends StatelessWidget {
  final TravelItem item;
  final int index;

  const ItemTravel({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (item.article!.urls != null && item.article!.urls!.isNotEmpty) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebView(
                          url: item.article?.urls![0].h5Url,
                          title: '详情',
                        )));
          }
        },
        child: Card(
          child: PhysicalModel(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemImage(),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    item.article!.articleTitle ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
                _infoText()
              ],
            ),
          ),
        ));
  }

  _itemImage() {
    return Stack(
      children: [
        Image.network(item.article!.images![0].dynamicUrl ?? ''),
        Positioned(
          left: 8,
          bottom: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  //位置信息
  String _poiName() {
    return item.article!.pois == null || item.article!.pois!.isEmpty
        ? '未知'
        : item.article!.pois![0].poiName ?? '未知';
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //裁剪Widget
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12), //圆角角度是 宽高一半 才能裁出圆形
                child: Image.network(
                  item.article?.author?.coverImage?.dynamicUrl ?? '',
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item.article?.author?.nickName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article?.likeCount.toString() ?? '',
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
