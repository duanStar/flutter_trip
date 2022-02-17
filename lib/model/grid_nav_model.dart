import 'dart:convert';

import 'grid_nav_item.dart';

class GridNavModel {
  final GridNavItem hotel;
  final GridNavItem flight;
  final GridNavItem travel;

  GridNavModel(
      {required this.hotel, required this.flight, required this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
        hotel: GridNavItem.fromJson(json['hotel']),
        flight: GridNavItem.fromJson(json['flight']),
        travel: GridNavItem.fromJson(json['travel']));
  }

  Map<String, dynamic> toJson() {
    return {
      "hotel": json.decode(json.encode(hotel)),
      "flight": json.decode(json.encode(flight)),
      "travel": json.decode(json.encode(travel))
    };
  }
}
