import 'dart:convert';

import 'package:flutter_trip/model/search_item.dart';

class SearchModel {
  String keyword;
  final List<SearchItem> searchList;

  SearchModel({required this.searchList, this.keyword = ""});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    var dataJson = json["data"] as List;
    List<SearchItem> data = dataJson.map((item) {
      return SearchItem.fromJson(item);
    }).toList();
    return SearchModel(searchList: data);
  }

  Map<String, dynamic> toJson() {
    return {"searchList": searchList};
  }
}
