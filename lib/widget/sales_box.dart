import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesBox({Key? key, required this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBox == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    items.add(_doubleItem(
        context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItem(
        context, salesBox.smallCard3, salesBox.smallCard4, false, true));
    return Column(
      children: [
        Container(
          height: 44,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2f2)))),
          margin: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                salesBox.icon,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [Color(0xffff4e163), Color(0xffff6cc9)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WebView(
                          url: salesBox.moreUrl,
                          title: "更多活动",
                          hideAppBar: false,
                          statusBarColor: "ffffff");
                    }));
                  },
                  child: Text(
                    "获取更多福利 >",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2),
        )
      ],
    );
  }

  Widget _item(
      BuildContext context, CommonModel model, bool big, bool left, bool last) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebView(
                url: model.url ?? "",
                title: model.title ?? "",
                hideAppBar: model.hideAppBar ?? false,
                statusBarColor: model.statusBarColor ?? "ffffff");
          }));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  right: left
                      ? BorderSide.none
                      : BorderSide(width: 0.8, color: Color(0xfff2f2f2)),
                  bottom: last
                      ? BorderSide.none
                      : BorderSide(width: 0.8, color: Color(0xfff2f2f2)))),
          child: Image.network(
            model.icon!,
            width: MediaQuery.of(context).size.width / 2 - 10,
            height: big ? 129 : 80,
          ),
        ));
  }

  Widget _doubleItem(BuildContext context, CommonModel leftCard,
      CommonModel rightCard, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftCard, big, true, last),
        _item(context, rightCard, big, false, last)
      ],
    );
  }
}
