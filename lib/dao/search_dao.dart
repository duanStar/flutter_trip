import 'dart:convert';
import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;

const SEARCH_URL =
    "https://m.ctrip.com/restapi/h5api/globalsearch/search?userid=M2208559994&source=mobileweb&action=mobileweb&keyword=";

class SearchDao {
  static Future<SearchModel> fetch(String keyword) async {
    final response = await http.get(SEARCH_URL + keyword);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result =
          json.decode(utf8decoder.convert(response.bodyBytes).toString());
      SearchModel searchModel = SearchModel.fromJson(result);
      searchModel.keyword = keyword;
      return searchModel;
    } else {
      throw Exception("Fail to load search data");
    }
  }
}
