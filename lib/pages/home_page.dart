import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/local_nav.dart';

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
  bool _loading = true;

  loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        bannerList = model.bannerList;
        gridNavModel = model.gridNav;
        _loading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
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
              )
            ],
          ),
        ),
      ),
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
              //   NavigatorUtil.push(
              //       context,
              //       WebView(
              //           url: model.url,
              //           title: model.title,
              //           hideAppBar: model.hideAppBar));
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
