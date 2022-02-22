import 'package:flutter/material.dart';
import 'package:niu_fluttertrip/model/gird_nav_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel? gridNavModel;

  const GridNav({Key? key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('GridNav');
  }
}
