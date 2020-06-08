import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterjuejin/routers/application.dart';

class SwiperPage extends StatelessWidget {
  final String pics;
  final String currentIndex;

  SwiperPage({Key key, this.pics, this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List picList = pics.split(',');
    int index = int.parse(currentIndex);
    return Center(
      child: Swiper(
        itemCount: picList.length,
        itemBuilder: (BuildContext content, int index) {
          return Image.network(
            picList[index],
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          );
        },
        scale: 0.8,
        pagination: new SwiperPagination(),
        index: index,
        onTap: (index) {
          Application.router.pop(context);
        },
      ),
    );
  }
}
