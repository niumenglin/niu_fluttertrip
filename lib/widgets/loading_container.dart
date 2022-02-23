import 'package:flutter/material.dart';

/// @author: niumenglin
/// @time: 2022/2/23-2:56 下午
/// @desc:加载进度条组件
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  //是否覆盖
  final bool cover;

  const LoadingContainer(
      {Key? key,
      required this.child,
      required this.isLoading,
      this.cover = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading
            ? child
            : _loadingView
        : Stack(
            children: [child, isLoading ? _loadingView : Container()],
          );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
