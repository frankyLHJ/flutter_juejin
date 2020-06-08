import 'package:flutter/material.dart';
import 'package:flutterjuejin/model/indexCell.dart';
import 'package:flutterjuejin/routers/application.dart';
import 'package:flutterjuejin/widgets/goodAndCommentCell.dart';
import 'package:flutterjuejin/widgets/inTextDot.dart';

class IndexListCell extends StatelessWidget {

  IndexListCell({Key key, this.cellInfo}) : super(key : key);

  final IndexCell cellInfo;

  final TextStyle titleTextStyle = TextStyle(
    color: Color(0xFFB2BAC2),
    fontWeight: FontWeight.w300,
    fontSize: 13.0,
  );

  // 第一行
  List<Widget> _buildFirstRow() {

    List<Widget> _listRow = new List();

    if (cellInfo.hot) {
      _listRow.add(Text(
        '热',
        style: TextStyle(
          color: Color(0xFFF53040),
          fontWeight: FontWeight.w600,
        ),
      ));
      _listRow.add(InTextDot());
    }

    if (cellInfo.isCollection == 'post') {
      _listRow.add(Text(
        '专栏',
        style: TextStyle(
          color: Color(0xFFBC30DA),
          fontWeight: FontWeight.w600,
        ),
      ));
      _listRow.add(InTextDot());
    }

    _listRow.add(Text(cellInfo.username, style: titleTextStyle));
    _listRow.add(InTextDot());
    _listRow.add(Text(cellInfo.createdTime, style: titleTextStyle));
    _listRow.add(InTextDot());
    _listRow.add(Expanded(
      // 文本过长显示省略号
      child: Text(
        cellInfo.tag,
        style: titleTextStyle,
        overflow: TextOverflow.ellipsis,
      ),
    ));

    return _listRow;

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('跳转详情页');
        Application.router.navigateTo(context, "/detail?id=${Uri.encodeComponent(cellInfo.detailUrl)}&title=${Uri.encodeComponent(cellInfo.title)}");
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildFirstRow(),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 9.0),
              child: Text(
                cellInfo.title,
                style: TextStyle(
                  color: Color(0xFF393C3F),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GoodAndCommentCell(cellInfo.collectionCount, cellInfo.commentCount),
            SizedBox(
              height: 15.0,
            ),
            Divider(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
