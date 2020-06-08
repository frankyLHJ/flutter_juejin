import 'package:flutter/material.dart';
import 'package:flutterjuejin/routers/application.dart';

class PinsCellTopic extends StatelessWidget {
  final Map<String, dynamic> topicInfo;

  PinsCellTopic({Key key, this.topicInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _textColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        String _preUrl = 'https://juejin.im/topic/${topicInfo["objectId"]}';
        Application.router.navigateTo(context,
            "/web?url=${Uri.encodeComponent(_preUrl)}&title=${Uri.encodeComponent(topicInfo['title'])}");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.5),
        decoration: BoxDecoration(
            border: Border.all(
              color: _textColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(15.0),
              right: Radius.circular(15.0),
            )),
        child: Text(topicInfo['title'], style: TextStyle(color: _textColor)),
      ),
    );
  }
}