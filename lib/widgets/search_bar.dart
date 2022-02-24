import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/model/common_model.dart';
import 'package:niu_fluttertrip/widgets/webview.dart';

///顶部SearchBar
///SearchBarType 类型枚举：首页状态、首页状态高亮、搜索状态
enum SearchBarType { home, homeLight, normal }

class SearchBar extends StatefulWidget {
  //是否禁止搜索
  final bool enabled;
  //是否隐藏左边按钮
  final bool hideLeft;
  final SearchBarType searchBarType;
  //默认提示文案
  final String hint;
  final String? defaultText;
  final void Function()? leftButtonClick;
  final void Function()? rightButtonClick;
  final void Function()? speakButtonClick;
  final void Function()? inputBoxClick;
  //内容变化回调
  final ValueChanged<String>? onChanged;

  const SearchBar(
      {Key? key,
      this.enabled = true,
      this.hideLeft = false,
      this.searchBarType = SearchBarType.normal,
      this.hint = '',
      this.defaultText,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakButtonClick,
      this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText!;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //根据类型判断显示Widget
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  _genNormalSearch() {
    return Container(
      child: Row(
        children: [
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: widget.hideLeft
                    ? null
                    : Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 26,
                      ),
              ),
              widget.leftButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: const Text(
                  '搜索',
                  style: TextStyle(fontSize: 17, color: Colors.blue),
                ),
              ),
              widget.rightButtonClick),
        ],
      ),
    );
  }

  _genHomeSearch() {
    return Container(
      child: Row(
        children: [
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
                child: Row(
                  children: [
                    Text(
                      '南京',
                      style: TextStyle(fontSize: 14, color: _homeFontColor()),
                    ),
                    Icon(
                      Icons.expand_more,
                      size: 22,
                      color: _homeFontColor(),
                    )
                  ],
                ),
              ),
              widget.leftButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  size: 26,
                  color: _homeFontColor(),
                ),
              ),
              widget.rightButtonClick),
        ],
      ),
    );
  }

  ///输入框Widget
  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15)),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? Color(int.parse('0xffA9A9A9'))
                : Colors.blue,
          ),
          Expanded(
              flex: 1,
              child: widget.searchBarType == SearchBarType.normal
                  ? TextField(
                      controller: _controller,
                      onChanged: _onChanged,
                      autofocus: true,
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      //输入文本样式，fix: 设置contentPadding属性时，必须设置isCollapsed属性值为true
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          border: InputBorder.none,
                          hintText: widget.hint,
                          hintStyle: const TextStyle(fontSize: 15)),
                    )
                  : _wrapTap(
                      Container(
                        child: Text(
                          widget.defaultText ?? '',
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      widget.inputBoxClick)),
          !showClear
              ? _wrapTap(
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchBarType == SearchBarType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  widget.speakButtonClick)
              : _wrapTap(
                  Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function()? callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: child,
    );
  }

  _onChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
