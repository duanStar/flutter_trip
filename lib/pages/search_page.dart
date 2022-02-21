import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_item.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/pages/speak_page.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/webview.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String keyword;

  const SearchPage(
      {Key? key, this.hideLeft = true, this.keyword = ""})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword = "";
  SearchModel? searchModel;

  @override
  void initState() {
    if (widget.keyword.isNotEmpty) {
      _onTextChange(widget.keyword);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _appBar(),
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
                child: ListView.separated(
              itemCount: searchModel?.searchList.length ?? 0,
              itemBuilder: (context, int index) {
                return _item(index);
              },
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 0.5,
                  color: Colors.grey,
                );
              },
            )))
      ],
    ));
  }

  _appBar() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
                hideLeft: widget.hideLeft,
                hint: widget.keyword,
                leftButtonClick: () {
                  Navigator.pop(context);
                },
                speakClick: _jumpToSpeak,
                rightButtonClick: () {},
                inputBoxClick: () {},
                onChanged: _onTextChange),
          ),
        )
      ],
    );
  }
  void _jumpToSpeak() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return const SpeakPage();
    }));
  }
  _item(int index) {
    if (searchModel == null || searchModel?.searchList == null) return null;
    SearchItem? item = searchModel?.searchList[index];
    return GestureDetector(
      onTap: () {
        if (item != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return WebView(url: item.url, title: "详情", hideAppBar: false);
          }));
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                height: 26,
                width: 26,
                image: AssetImage(_typeImage(item?.type ?? "")),
              ),
            ),
            Column(
              children: [
                Container(width: 300, child: _title(item)),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 5),
                  child: _subtitle(item),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onTextChange(String text) async {
    setState(() {
      keyword = text;
    });
    if (text.isNotEmpty) {
      try {
        SearchModel model = await SearchDao.fetch(text);
        if (keyword == model.keyword) {
          setState(() {
            searchModel = model;
          });
        }
      } catch (err) {
        print(err);
      }
    } else {
      setState(() {
        searchModel = null;
      });
    }
  }

  String _typeImage(String type) {
    if (type == "") {
      return "images/type_travelgroup.png";
    }
    String path = "travelgroup";
    for (var i in TYPES) {
      if (type.contains(i)) {
        path = i;
        // break;
      }
    }
    return "images/type_${path}.png";
  }

  _title(SearchItem? item) {
    if (item == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, keyword));
    spans.add(TextSpan(
        text:
            " ${item.districtname == null ? "" : item.districtname} ${item.zonename == null ? "" : item.zonename}",
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _subtitle(SearchItem? item) {
    if (item == null) return null;
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: item.price == null ? "" : item.price,
          style: TextStyle(fontSize: 16, color: Colors.orange)),
      TextSpan(
          text: " ${item.type == null ? "" : item.type}",
          style: TextStyle(fontSize: 12, color: Colors.grey))
    ]));
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.isEmpty) return spans;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    for (int i = 0; i < arr.length; i++) {
      if (i > 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      var value = arr[i];
      if (value.isNotEmpty) {
        spans.add(TextSpan(text: value, style: normalStyle));
      }
    }
    return spans;
  }
}
