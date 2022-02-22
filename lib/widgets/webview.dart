import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart' as web;
import 'package:webview_flutter/webview_flutter.dart';

/// @author: niumenglin
/// @time: 2022/2/22-3:46 下午
/// @desc:WebView
const CATCH_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5'
]; //白名单

class WebView extends StatefulWidget {
  final String? url;
  final String? title;
  //状态栏颜色
  final String? statusBarColor;
  //是否隐藏AppBar
  final bool? hideAppBar;
  //是否禁止返回
  final bool backForbid;

  const WebView(
      {Key? key,
      this.url,
      this.title,
      this.statusBarColor,
      this.hideAppBar,
      this.backForbid = false})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewController _controller;
  bool exiting = false;
  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) {
    //   web.WebView.platform = SurfaceAndroidWebView();
    // }
  }

  ///是否在白名单内
  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url.endsWith(value)) {
        //在白名单里面
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: [
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
              child: web.WebView(
            initialUrl: widget.url ?? '',
            //是否支持js 默认是不支持的
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
              if (_isToMain(url) && !exiting) {
                if (widget.backForbid) {
                  //禁止返回，加载当前页面
                  _controller.loadUrl(widget.url!);
                } else {
                  Navigator.pop(context);
                  exiting = true;
                }
              }
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },

            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ))
        ],
      ),
    );
  }

  _appBar(Color? backgroundColor, Color? backButtonColor) {
    if (widget.hideAppBar ?? false) {
      //隐藏状态下
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
