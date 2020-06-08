import 'package:flutter/material.dart';
import 'package:flutterjuejin/constants/constants.dart';
import 'package:flutterjuejin/model/indexCell.dart';
import 'package:flutterjuejin/util/dataUtils.dart';
import 'package:flutterjuejin/widgets/indexListCell.dart';
import 'package:flutterjuejin/widgets/indexListHeader.dart';
import 'package:flutterjuejin/widgets/loadMore.dart';

const pageIndexArray = Constants.RANK_BEFORE;

// 首页
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<IndexCell> _listData = const [];

  int _pageIndex = 0;

  Map<String, dynamic> _params = {"src": 'web', "category": "all", "limit": 20};

  bool netError = false;

  bool _isRequesting = false; //是否正在请求数据的flag
  bool _hasMore = true;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getList(false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // 加载更多
        getList(true);
      }
    });
  }

  getList(bool isLoadMore) {
    if (_isRequesting || !_hasMore) return;
    if (!isLoadMore) {
      // reload的时候重置page
      _pageIndex = 0;
    }
    _params['before'] = pageIndexArray[_pageIndex];
    _isRequesting = true;
    DataUtils.getIndexListData(_params).then((result) {
      _pageIndex += 1;
      List<IndexCell> resultList = new List();
      if (isLoadMore) {
        resultList.addAll(_listData);
      }
      resultList.addAll(result);
      setState(() {
        _listData = resultList;
        _hasMore = _pageIndex < pageIndexArray.length;
        _isRequesting = false;
      });
    }, onError: (err) => {
      setState(() {
        netError = true;
      })
    }).catchError((error) => {print(error)});
  }

  // 渲染item
  _renderItem(context, index) {
    if (index == 0) {
      return IndexListHeader(false);
    }
    if (index == _listData.length + 1) {
      return LoadMore(_hasMore);
    }
    return IndexListCell(cellInfo: _listData[index - 1]);
  }

  // 下拉刷新
  Future<void> _onRefresh() async{
    _listData.clear();
    setState(() {
      _listData = _listData;
      //注意这里需要重置一切请求条件
      _hasMore = true;
    });
    getList(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {

    if (netError) {
      return Center(
        child: Text('网络异常～'),
      );
    }

    if (_listData.length <= 0 && !netError) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: _listData.length + 2, // 有一个头部
        itemBuilder: (context, index) => _renderItem(context, index),
        controller: _scrollController,
      ),
    );
  }
}
