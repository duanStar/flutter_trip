import 'package:flutter_trip/model/travel_item.dart';

class TravelModel {
  int totalCount;
  List<TravelItem> travelItems;

  TravelModel({required this.totalCount, required this.travelItems});

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    List results = json['resultList'] as List;
    List<TravelItem> _results =
        results.map((item) => TravelItem.fromJson(item)).toList();
    return TravelModel(
        totalCount: json['totalCount'], travelItems: _results);
  }

  Map<String, dynamic> toJson() {
    return {"totalCount": totalCount, "travelItems": travelItems};
  }
}
