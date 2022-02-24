import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/widgets/search_bar.dart';

///搜索
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
            onChanged: _onTextChange,
          )
        ],
      ),
    );
  }

  _onTextChange(text) {}
}
