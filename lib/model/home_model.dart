import 'dart:convert';

import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel(
      {required this.config,
      required this.bannerList,
      required this.localNavList,
      required this.gridNav,
      required this.salesBox,
      required this.subNavList});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> _localNavList =
        localNavListJson.map((item) => CommonModel.fromJson(item)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> _bannerList =
        bannerListJson.map((item) => CommonModel.fromJson(item)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> _subNavList =
        subNavListJson.map((item) => CommonModel.fromJson(item)).toList();
    return HomeModel(
        config: ConfigModel.fromJson(json['config']),
        bannerList: _bannerList,
        localNavList: _localNavList,
        gridNav: GridNavModel.fromJson(json['gridNav']),
        salesBox: SalesBoxModel.fromJson(json['salesBox']),
        subNavList: _subNavList);
  }

  Map<String, dynamic> toJson() {
    return {
      "config": json.decode(json.encode(config)),
      "bannerList": bannerList,
      "localNavList": localNavList,
      "gridNav": json.decode(json.encode(gridNav)),
      "subNavList": subNavList,
      "salesBox": json.decode(json.encode(salesBox))
    };
  }
}
