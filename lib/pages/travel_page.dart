import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/travel_tab.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:flutter_trip/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key? key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TravelTabModel _travelTabModel;
  List<TravelTab> _tabs = [];

  loadData() async {
    try {
      TravelTabModel travelTabModel = await TravelDao.fetchTabs();
      setState(() {
        _tabs = travelTabModel.tabs;
        _travelTabModel = travelTabModel;
        _tabController =
            TabController(length: travelTabModel.tabs.length, vsync: this);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: _tabs.length > 0
          ? Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                    labelColor: Colors.black,
                    indicator: const UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: Color(0xff2fcfbb), width: 3),
                      insets: EdgeInsets.only(bottom: 10),
                    ),
                    tabs: _tabs.map((tab) {
                      return Tab(
                        text: tab.name,
                      );
                    }).toList(),
                  ),
                ),
                Flexible(
                    child: TabBarView(
                  children: _tabs.map((tab) {
                    return TravelTabPage(groupChannelCode: tab.code);
                  }).toList(),
                  controller: _tabController,
                ))
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    ));
  }
}
