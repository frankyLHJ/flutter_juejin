import 'package:flutterjuejin/api/api.dart';
import 'package:flutterjuejin/model/bookCell.dart';
import 'package:flutterjuejin/model/bookNav.dart';
import 'package:flutterjuejin/model/pinsCell.dart';
import 'package:flutterjuejin/util/netUtils.dart';
import '../model/indexCell.dart';

import 'dart:async' show Future;

class DataUtils {
//  static Future<String> _loadIndexListAsset() async {
//    return await rootBundle.loadString('assets/indexListData.json');
//  }

  // 首页 列表
  static Future<List<IndexCell>> getIndexListData(Map<String, dynamic> params) async {
    var response = await NetUtils.get(Api.RANK_LIST, params: params);
    var responseList = response['d']['entrylist'];
    List<IndexCell> resultList = new List();
    for(int i = 0;i<responseList.length;i++){
      IndexCell cellData = new IndexCell.fromJson(responseList[i]);
      resultList.add(cellData);
    }
    return resultList;
  }

  // 沸点列表
  static Future<List<PinsCell>> getPinsListData(Map<String, dynamic> params) async {
    List<PinsCell> resultList = new List();
    var response = await NetUtils.get(Api.PINS_LIST, params: params);
    var responseList = response['d']['list'];
    for (int i = 0; i < responseList.length; i++) {
      PinsCell pinsCell;
      try {
        pinsCell = PinsCell.fromJson(responseList[i]);
      } catch (e) {
        print("error $e at $i");
        continue;
      }
      resultList.add(pinsCell);
    }

    return resultList;
  }

  // 获取小册导航栏
  static Future<List<BookNav>> getBookNavData() async {
    List<BookNav> resultList = [];
    var response = await NetUtils.get(Api.BOOK_NAV);
    var responseList = response['d'];
    for (int i = 0; i < responseList.length; i++) {
      BookNav bookNav;
      try {
        bookNav = BookNav.fromJson(responseList[i]);
      } catch (e) {
        print("error $e at $i");
        continue;
      }
      resultList.add(bookNav);
    }

    return resultList;
  }

  // 获取小册
  static Future<List<BookCell>> getBookListData(
      Map<String, dynamic> params) async {
    List<BookCell> resultList = new List();
    var response = await NetUtils.get(Api.BOOK_LIST, params: params);
    var responseList = response['d'];
    for (int i = 0; i < responseList.length; i++) {
      BookCell bookCell;
      try {
        bookCell = BookCell.fromJson(responseList[i]);
      } catch (e) {
        print("error $e at $i");
        continue;
      }
      resultList.add(bookCell);
    }

    return resultList;
  }
}

