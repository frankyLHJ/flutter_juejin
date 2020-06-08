import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetail extends StatelessWidget {

  ArticleDetail(this.articleId, this.title);

  final String articleId;
  final String title;

  final double lineProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: articleId,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

}
