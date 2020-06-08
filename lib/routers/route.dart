import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuejin/routers/router_handler.dart';

class Routes {

  static String root = '/';
  static String articleDetail = '/detail';
  static String webViewPage = '/web';
  static String swipPage = '/swip';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("ROUTE WAS NOT FOUND !!!");
        return ;
      }
    );

    // 文章详情页路由
    router.define(
        articleDetail,
        handler: articleDetailHandler,
        transitionType: TransitionType.cupertino
    );
    router.define(webViewPage, handler: webPageHandler);
    router.define(swipPage, handler: swipPageHandler);
  }
}