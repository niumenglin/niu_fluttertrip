import 'dart:math';

import 'package:flutter/material.dart';

class WaterMark extends StatelessWidget {
  final int rowCount;
  final int columnCount;
  final String text;

  const WaterMark(
      {Key? key,
      required this.rowCount,
      required this.columnCount,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
          child: Column(
        children: createColumnWidgets(),
      )),
    );
  }

  List<Widget> createColumnWidgets() {
    List<Widget> list = [];
    for (var i = 0; i < columnCount; i++) {
      final widget = Expanded(
          child: Row(
        children: createRowWidgets(),
      ));
      list.add(widget);
    }
    return list;
  }

  List<Widget> createRowWidgets() {
    List<Widget> list = [];
    for (var i = 0; i < rowCount; i++) {
      final widget = Expanded(
          child: Center(
              child: Transform.rotate(
        angle: -(pi / 10), //pi=180度
        child: Text(
          text,
          style: TextStyle(
              color: Color(0x08000000),
              fontSize: 18,
              decoration: TextDecoration.none),
        ),
      )));
      list.add(widget);
    }
    return list;
  }
}
