class SearchItem {
  final String word;
  final String type;
  final String price;
  final String star;
  final String zonename;
  final String districtname;
  final String url;

  SearchItem(
      {this.word = "",
      this.type = "",
      this.price = "",
      this.star = "",
      this.zonename = "",
      this.districtname = "",
      required this.url});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
        url: json["url"],
        word: json["word"],
        type: json["type"],
        price: json["price"],
        star: json["star"],
        zonename: json["zonename"],
        districtname: json["districtname"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "word": word,
      "type": type,
      "price": price,
      "star": star,
      "zonename": zonename,
      "districtname": districtname,
      "url": url
    };
  }
}
