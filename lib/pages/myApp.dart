import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuejin/routers/application.dart';
import 'package:flutterjuejin/routers/route.dart';

import 'activityPage.dart';
import 'bookPage.dart';
import 'indexPage.dart';
import 'pinsPage.dart';
import 'reposPage.dart';

// 页面总入口
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  _MyAppState() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  final TextStyle tabTextStyleNormal =
  TextStyle(color: const Color(0xffdddddd));
  final TextStyle tabTextStyleSelected =
  TextStyle(color: const Color(0xff4d91fd));

  // 底部bar
  final List<Tab> _bottomTabs = <Tab>[
    Tab(
      text: '首页',
      icon: Icon(Icons.home),
    ),
    Tab(
      text: '沸点',
      icon: Icon(Icons.chat),
    ),
    Tab(
      text: '小册',
      icon: Icon(Icons.book),
    ),
    Tab(
      text: '开源库',
      icon: Icon(Icons.bubble_chart),
    ),
    Tab(
      text: '活动',
      icon: Icon(Icons.local_activity),
    ),
  ];

//  var _body;
//
//  List _appBarTitles = ['首页', '沸点', '小册', '开源库', '活动'];

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: _bottomTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(77, 145, 253, 1.0),
          accentColor: const Color(0xFFB2BAC2),
        ),
        home: Scaffold(
          appBar: AppBar(
            leading: Image.asset('images/logo.jpg'),
            backgroundColor: Colors.white,
            title: Text('Flutter 版 web 掘金'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print('登录');
                },
                child: Text(
                  '登陆 . 注册',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              )
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              IndexPage(),
              PinsPage(),
              BookPage(),
              ReposPage(),
              ActivityPage()
            ],
          ),
          bottomNavigationBar: new Material(
            color: Colors.white,
            child: TabBar(
              tabs: _bottomTabs,
              controller: _tabController,
              indicator: const BoxDecoration(),
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
            ),
          ),
        ),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
