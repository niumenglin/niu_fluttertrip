import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

///带lottie动画的加载进度条组件
class LoadingView extends StatelessWidget {
  final Widget child;
  //是否正在加载 默认=true
  final bool isLoading;
  //加载动画是否覆盖在原有界面上 默认=false
  final bool cover;

  const LoadingView(
      {Key? key,
      required this.child,
      this.isLoading = true,
      this.cover = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [child, isLoading ? _buildLoadingView : Container()],
      );
    } else {
      return isLoading ? _buildLoadingView : child;
    }
  }

  Widget get _buildLoadingView {
    return Center(
      child: Lottie.asset('assets/jsons/loading_paperplane.json'),
      // child: Lottie.asset('assets/jsons/loading_dots_in_yellow.json'),
      // child: Lottie.asset('assets/jsons/page_error_404.json'),
    );
  }
}
