import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/widgets/loading_view.dart';

/// @author: niumenglin
/// @time: 2022/3/8-10:39 下午
/// @desc:Lottie动画
class TestLottiePage extends StatefulWidget {
  const TestLottiePage({Key? key}) : super(key: key);

  @override
  _TestLottiePageState createState() => _TestLottiePageState();
}

class _TestLottiePageState extends State<TestLottiePage> {
  int _counter = 0;

  //是否loading，默认true
  bool isLoading = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
      //正在加载
      isLoading = true;
    });

    loadData();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  ///模拟延迟5秒执行加载数据
  void loadData() async {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        //加载完成
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('测试Lottie'),
      ),
      body: LoadingView(
        isLoading: isLoading,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
