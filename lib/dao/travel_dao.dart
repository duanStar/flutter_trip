import 'dart:convert';

import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const TRAVEL_TAB_URL =
    "https://m.ctrip.com/restapi/soa2/15612/json/getTripShootHomePage?_fxpcqlniredt=09031018413688679720&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5";

const TRAVEL_TAN_DETAIL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031018413688679720&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelDao {
  static Future<TravelTabModel> fetchTabs() async {
    http.Response response = await http.post(TRAVEL_TAB_URL,
        body: json.encode({
          "contentType": "json",
          "head": {'cid': "09031014111431397988"},
        }));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      TravelTabModel travelTabModel = TravelTabModel.fromJson(
          json.decode(utf8decoder.convert(response.bodyBytes)));
      return travelTabModel;
    } else {
      throw Exception("Fail to load tabs data");
    }
  }

  static Future<TravelModel> fetchTabDetail(
      {String groupChannelCode = "tourphoto_global1",
      int pageIndex = 1,
      int pageSize = 10}) async {
    http.Response response = await http.post(TRAVEL_TAN_DETAIL_URL,
        body: json.encode({
          "contentType": "json",
          "head": {'cid': "09031014111431397988"},
          "groupChannelCode": groupChannelCode,
          "pagePara": {
            "pageIndex": pageIndex,
            "pageSize": pageSize,
            "sortType": 9,
            "sortDirection": 0
          }
        }));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      TravelModel travelModel = TravelModel.fromJson(
          json.decode(utf8decoder.convert(response.bodyBytes)));
      return travelModel;
    } else {
      throw Exception("Fail to load detail data");
    }
  }
}
