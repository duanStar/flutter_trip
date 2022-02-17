import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String resultString = "";

  loadData() async {
    try {
      HomeModel result = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(result);
      });
    } catch (e) {
      resultString = e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Text(resultString),
        ),
      ),
    );
  }
}
