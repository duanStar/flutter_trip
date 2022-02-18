import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key? key, required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((item) {
      items.add(_item(context, item));
    });
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WebView(
                  url: model.url ?? "",
                  title: model.title ?? "",
                  hideAppBar: model.hideAppBar ?? false,
                  statusBarColor: model.statusBarColor ?? "ffffff");
            }));
          },
          child: Column(
            children: [
              Image.network(
                model.icon ?? "",
                width: 18,
                height: 18,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  model.title ?? "",
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ));
  }
}
