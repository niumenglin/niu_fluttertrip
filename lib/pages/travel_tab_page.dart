import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/dao/travel_dao.dart';
import 'package:niu_fluttertrip/model/travel_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

class _TravelTabPageState extends State<TravelTabPage> {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;

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
      body: MasonryGridView.count(
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
      ),
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
    return Text('$index');
  }
}
