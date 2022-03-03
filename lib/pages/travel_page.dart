import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/dao/travel_tab_dao.dart';
import 'package:niu_fluttertrip/model/travel_tab_model.dart';
import 'package:niu_fluttertrip/pages/travel_tab_page.dart';

///旅拍
class TravelPage extends StatefulWidget {
  const TravelPage({Key? key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel? travelTabModel;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel? model) {
      _controller = TabController(
          length: model!.tabs!.length, vsync: this); //fix tab label 空白问题
      setState(() {
        tabs = model.tabs ?? [];
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                    insets: EdgeInsets.only(bottom: 10)),
                tabs: tabs.map<Tab>((TravelTab tab) {
                  return Tab(
                    text: tab.labelName,
                  );
                }).toList()),
          ),
          Expanded(
            //Expanded或Flexible  设置高度。直接将TabBarView作为Column子元素，而不设置高度，会报错
            flex: 1,
            child: TabBarView(
                controller: _controller,
                children: tabs.map((TravelTab tab) {
                  return TravelTabPage(
                    travelUrl: travelTabModel!.url,
                    groupChannelCode: tab.groupChannelCode,
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
