import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/pages/search_page.dart';
import 'package:niu_fluttertrip/plugins/asr_manager.dart';
import 'package:niu_fluttertrip/utils/navigator_util.dart';

/// @author: niumenglin
/// @time: 2022/3/7-10:14 下午
/// @Email: menglin.nml@ncarzone.com
/// @desc:语音识别页
class SpeakPage extends StatefulWidget {
  const SpeakPage({Key? key}) : super(key: key);

  @override
  _SpeakPageState createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage>
    with SingleTickerProviderStateMixin {
  String speakTips = '长按说话';
  String speakResult = '';
  late Animation<double> _animation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse(); //反向执行，这样就能实现循环动画

        } else if (status == AnimationStatus.dismissed) {
          //动画关闭，开始动画
          _controller.forward();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_topItem(), _bottomItem()],
          ),
        ),
      ),
    );
  }

  _topItem() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            '你可以这样说',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        Text(
          '故宫门票\n南京一日游\n迪士尼乐园',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            speakResult,
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
      ],
    );
  }

  _bottomItem() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (e) {
              //按下
              _speakStart();
            },
            onTapUp: (e) {
              //手指松开
              _speakStop();
            },
            onTapCancel: () {
              //手指长按滑出
              _speakStop();
            },
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      speakTips,
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        //占坑，避免动画执行过程中导致父布局大小变化
                        width: MIC_SIZE,
                        height: MIC_SIZE,
                      ),
                      Center(
                        child: AnimatedMic(animation: _animation),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 0,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  NavigatorUtil.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.grey,
                ),
              ))
        ],
      ),
    );
  }

  _speakStart() {
    _controller.forward();
    setState(() {
      speakTips = '- 识别中 -';
    });
    AsrManager.start().then((text) {
      if (text != null && text.isNotEmpty) {
        setState(() {
          speakResult = text;
        });
        //先关闭当前页面，然后再进行页面跳转
        NavigatorUtil.pop(context);
        NavigatorUtil.push(
            context,
            SearchPage(
              keyword: speakResult,
            ));
        print('----识别结果------$text');
      }
    }).catchError((e) {
      print('----识别Error------${e.toString()}');
    });
  }

  _speakStop() {
    setState(() {
      speakTips = '长按说话';
    });
    _controller.reset();
    _controller.stop();
    AsrManager.stop();
  }
}

const double MIC_SIZE = 80;

class AnimatedMic extends AnimatedWidget {
  //透明度动画
  static final _opacityTween = Tween<double>(begin: 1, end: 0.5);
  //大小动画
  static final _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 20);

  const AnimatedMic({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(MIC_SIZE / 2),
        ),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
