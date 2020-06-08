import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuejin/pages/articleDetail.dart';
import 'package:flutterjuejin/pages/swiperPage.dart';

Handler articleDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String articleId = params['id']?.first;
  String title = params['title']?.first;
  print('index>,articleDetail id is $articleId');
  return ArticleDetail(articleId, title);
});

Handler webPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String articleUrl = params['url']?.first;
  String title = params['title']?.first;
  print('$articleUrl and  $title');
  return ArticleDetail(articleUrl, title);
});

Handler swipPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String pics = params['pics']?.first;
  String index = params['currentIndex']?.first;
  print(pics);
  return SwiperPage(
    pics: pics,
    currentIndex: index,
  );
});
