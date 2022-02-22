class TravelTab {
  String code;
  String name;

  TravelTab({required this.code, required this.name});

  factory TravelTab.fromJson(Map<String, dynamic> json) {
    return TravelTab(code: json['code'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {"code": code, "name": name};
  }
}
