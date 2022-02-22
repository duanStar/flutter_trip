import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  final String url;
  final String? statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView(
      {Key? key,
      required this.url,
      required this.title,
      required this.hideAppBar,
      this.statusBarColor, this.backForbid = false})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  late StreamSubscription<String> _onUrlChange;
  late StreamSubscription<WebViewStateChanged> _onStateChange;
  late StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChange = webviewReference.onUrlChanged.listen((String url) {});
    _onStateChange =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              webviewReference.stopLoading();
              webviewReference.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error.toString());
    });
  }

  isToMain(String? url) {
    bool contain = false;
    for(final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColor = widget.statusBarColor ?? "ffffff";
    Color backButtonColor;
    if (statusBarColor == "ffffff") {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: [
          _appBar(Color(int.parse("0xff" + statusBarColor)), backButtonColor),
          Expanded(
              child: WebviewScaffold(
            url: widget.url,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    } else {
      return Container(
        color: backgroundColor,
        padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    color: backButtonColor,
                    size: 26,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 20, color: backButtonColor),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _onUrlChange.cancel();
    _onStateChange.cancel();
    _onHttpError.cancel();
    webviewReference.close();
    webviewReference.dispose();
    super.dispose();
  }
}
