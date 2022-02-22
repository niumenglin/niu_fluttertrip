import 'package:niu_fluttertrip/model/common_model.dart';
import 'package:niu_fluttertrip/model/config_model.dart';
import 'package:niu_fluttertrip/model/gird_nav_model.dart';
import 'package:niu_fluttertrip/model/sales_box_model.dart';

///首页模型
class HomeModel {
  final ConfigModel? config;
  final List<CommonModel>? bannerList;
  final List<CommonModel>? localNavList;
  final List<CommonModel>? subNavList;
  final GridNavModel? gridNav;
  final SalesBoxModel? salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.gridNav,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((e) => CommonModel.fromJson(e)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    return HomeModel(
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['config'] = config;
    data['gridNav'] = gridNav;
    data['salesBox'] = salesBox;
    if (bannerList != null) {
      data['bannerList'] = bannerList!.map((v) => v.toJson()).toList();
    }
    if (localNavList != null) {
      data['localNavList'] = localNavList!.map((v) => v.toJson()).toList();
    }
    if (subNavList != null) {
      data['subNavList'] = subNavList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
