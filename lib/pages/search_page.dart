import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/dao/search_dao.dart';
import 'package:niu_fluttertrip/widgets/search_bar.dart';

///搜索
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String showText = '';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SearchBar(
            hideLeft: true,
            defaultText: '哈哈',
            hint: '请在此输入关键词~',
            leftButtonClick: () {
              Navigator.pop(context);
            },
            rightButtonClick: () {
              SearchDao.fetch('长城').then((value) {
                setState(() {
                  showText = value!.data![0].url!;
                });
              });
            },
            onChanged: _onTextChange,
          ),
          Text(showText),
        ],
      ),
    );
  }

  _onTextChange(text) {}
}
