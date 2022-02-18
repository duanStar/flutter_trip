import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  late GridNavModel gridNavModel;
  late SalesBoxModel salesBox;
  List<CommonModel> subNavList = [];
  bool _loading = true;
  bool isReady = false;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        subNavList = model.subNavList;
        gridNavModel = model.gridNav;
        salesBox = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
        isReady = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
        isReady = true;
      });
    }
  }

  @override
  void initState() {
    _handleRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: isReady
            ? Stack(
                children: [
                  MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: NotificationListener(
                          onNotification: (scrollNotification) {
                            if (scrollNotification
                                    is ScrollUpdateNotification &&
                                scrollNotification.depth == 0) {
                              //滚动且是列表滚动的时候
                              _onScroll(scrollNotification.metrics.pixels);
                            }
                            return false;
                          },
                          child: _listView,
                        ),
                      )),
                  _appBar
                ],
              )
            : Container(),
      ),
    );
  }

  Widget get _appBar {
    return Opacity(
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页', style: TextStyle(fontSize: 18),),
          ),
        ),
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: [
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: GridNav(
            gridNavModel: gridNavModel,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SalesBox(salesBox: salesBox),
        ),
      ],
      physics: AlwaysScrollableScrollPhysics(),
    );
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList[index];
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WebView(
                    url: model.url ?? "",
                    title: model.title ?? "",
                    hideAppBar: model.hideAppBar ?? false,
                    statusBarColor: model.statusBarColor ?? "ffffff");
              }));
            },
            child: Image.network(
              bannerList[index].icon ?? "",
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}
