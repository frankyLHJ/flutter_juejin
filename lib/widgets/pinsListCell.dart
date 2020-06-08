import 'package:flutter/material.dart';
import 'package:flutterjuejin/model/pinsCell.dart';
import 'package:flutterjuejin/widgets/pinsCellBottomButton.dart';
import 'package:flutterjuejin/widgets/pinsCellHeader.dart';
import 'package:flutterjuejin/widgets/pinsCellPic.dart';
import 'package:flutterjuejin/widgets/pinsCellTopic.dart';
import 'package:flutterjuejin/widgets/pinsCellUrl.dart';

import 'PinsCellLink.dart';

class PinsListCell extends StatefulWidget {
  final PinsCell pinsCell;

  PinsListCell({Key key, this.pinsCell}) : super(key: key);

  @override
  _PinsListCellState createState() => _PinsListCellState();
}

class _PinsListCellState extends State<PinsListCell> {
  TextStyle _textStyle = TextStyle(color: Colors.black);

  List<Widget> _buildContent(String content) {
    List<Widget> contentList = new List();
    RegExp url = new RegExp(r"((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+");
    List listString = content.split(url);
    List listUrl = new List();
    Iterable<Match> matches = url.allMatches(content);
    int urlIndex = 0;
    for (Match m in matches) {
      listUrl.add(m.group(0));
    }
    for (var i = 0; i < listString.length; i++) {
      if (listString[i] == '') {
        // 空字符串说明应该填充Url
        contentList.add(PinsCellLink(
          linkUrl: listUrl[urlIndex],
        ));
        urlIndex += 1;
      } else {
        contentList.add(Text(
          listString[i],
          style: _textStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ));
      }
    }
    return contentList;
  }

  Widget _renderContent(String content) {
    return Wrap(
      direction: Axis.horizontal,
      verticalDirection: VerticalDirection.down,
      spacing: 10.0,
      children: _buildContent(content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                PinsCellHeader(
                  userInfo: widget.pinsCell.user,
                  createdAt: widget.pinsCell.createdAt,
                ),
                _renderContent(widget.pinsCell.content),
                widget.pinsCell.url == ''
                ? PinsCellPic(
                  pics: widget.pinsCell.pictures,
                ) : PinsCellUrl(
                  url: widget.pinsCell.url,
                  urlPic: widget.pinsCell.urlPic,
                  urlTitle: widget.pinsCell.urlTitle,
                ),
                widget.pinsCell.topic.length == 0
                ? Container() : PinsCellTopic(
                  topicInfo: widget.pinsCell.topic,
                ),
              ],
            ),
          ),
          PinsCellBottomButton(
            commentCount: widget.pinsCell.commentCount,
            likedCount: widget.pinsCell.likedCount,
          )
        ],
      ),
    );
  }
}
