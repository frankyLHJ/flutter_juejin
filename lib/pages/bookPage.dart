import 'package:flutter/material.dart';
import 'package:flutterjuejin/model/bookNav.dart';
import 'package:flutterjuejin/util/dataUtils.dart';

import 'bookPageTabView.dart';

// 小册页
class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with SingleTickerProviderStateMixin {

  List<BookNav> _navData = new List();
  List<Tab> _myTabs = <Tab>[
    Tab(
      text: '全部',
    )
  ];
  List<BookPageTabView> _myTabView = <BookPageTabView>[
    BookPageTabView(
      alias: 'all',
    )
  ];

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavList();
  }

  getNavList() {
    DataUtils.getBookNavData().then((resultData) {
      resultData.forEach((BookNav bn) {
        _myTabs.add(Tab(
          text: bn.name,
        ));
        _myTabView.add(BookPageTabView(
          alias: bn.alias,
        ));
      });
      if (this.mounted) {
        setState(() {
          _navData = resultData;
        });
        _tabController = new TabController(length: _navData.length + 1, vsync: this);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_navData.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: new TabBar(
          controller: _tabController,
          tabs: _myTabs,
          indicatorColor: Colors.white,
          isScrollable: true,
        ),
      ),
      body: new TabBarView(
          children: _myTabView,
        controller: _tabController,
      ),
    );
  }
}
