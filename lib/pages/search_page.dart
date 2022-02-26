import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/dao/search_dao.dart';
import 'package:niu_fluttertrip/model/search_model.dart';
import 'package:niu_fluttertrip/widgets/search_bar.dart';
import 'package:niu_fluttertrip/widgets/webview.dart';

///搜索
class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String? searchUrl;
  final String? keyword;
  final String? hint;

  const SearchPage(
      {Key? key,
      this.hideLeft = true,
      this.searchUrl = SEARCH_URL,
      this.keyword,
      this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  SearchModel? searchModel;
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          _appBar(),

          //ListView.builder效率更高
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: searchModel?.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int position) {
                        return _item(position);
                      }))),
        ],
      ),
    );
  }

  _appBar() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 80,
            decoration: const BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword ?? '',
              hint: widget.hint ?? '',
              leftButtonClick: () {
                Navigator.pop(context);
              },
              rightButtonClick: () {},
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  _onTextChange(text) {
    keyword = text; //监听输入框值并自动赋值
    if (text.length == 0) {
      //清空搜索关键字时，刷新列表为空
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl! + text;
    SearchDao.fetch2(url, text).then((value) {
      //只有当前输入的内容和服务器端返回的内容一致时才渲染
      if (value!.keyword == keyword) {
        setState(() {
          searchModel = value;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  _item(int position) {
    if (searchModel == null) {
      return null;
    }
    SearchItem item = searchModel!.data![position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: item.url,
                      title: '详情',
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 300,
                  child: Text(
                      '${item.word ?? ''} ${item.districtname ?? ''} ${item.zonename ?? ''}'),
                ),
                Container(
                  width: 300,
                  child: Text('${item.price ?? ''} ${item.type ?? ''}'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
