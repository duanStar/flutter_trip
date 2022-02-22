import 'package:flutter_trip/model/travel_tab.dart';

class TravelTabModel {
  String url;
  List<TravelTab> tabs;

  TravelTabModel({required this.url, required this.tabs});

  factory TravelTabModel.fromJson(Map<String, dynamic> json) {
    List groups = json['district']['groups'] as List;
    List<TravelTab> tabs =
        groups.map((item) => TravelTab.fromJson(item)).toList();
    return TravelTabModel(url: "", tabs: tabs);
  }

  Map<String, dynamic> toJson() {
    return {"url": url, "tabs": tabs};
  }
}
