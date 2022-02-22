import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/webview.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
      url: "https://m.ctrip.com/webapp/myctrip",
      title: "登录",
      hideAppBar: true,
      backForbid: true,
      statusBarColor: '4c5bca',
    ));
  }
}
