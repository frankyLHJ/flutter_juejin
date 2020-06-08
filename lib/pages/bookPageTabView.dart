import 'package:flutter/material.dart';
import 'package:flutterjuejin/model/bookCell.dart';
import 'package:flutterjuejin/util/dataUtils.dart';
import 'package:flutterjuejin/widgets/bookListCell.dart';

class BookPageTabView extends StatefulWidget {
  final String alias;
  BookPageTabView({Key key, this.alias}) : super(key: key);

  @override
  _BookPageTabViewState createState() => _BookPageTabViewState();
}

class _BookPageTabViewState extends State<BookPageTabView> {
  Map<String, dynamic> _params = {
    "uid": '',
    'client_id': '',
    'token': '',
    'src': 'web',
    'pageNum': 1
  };
  List<BookCell> _bookList = <BookCell>[];

  getBookList() {
    if (widget.alias == 'all') {
      _params['alias'] = '';
    } else {
      _params['alias'] = widget.alias;
    }
    DataUtils.getBookListData(_params).then((resultList) {
      if (this.mounted) {
        setState(() {
          _bookList = resultList;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBookList();
  }

  Widget _itemBuilder(context,index){
    return BookListCell(cellData: _bookList[index],);
  }

  @override
  Widget build(BuildContext context) {
    if (_bookList.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemBuilder: _itemBuilder,
      itemCount: _bookList.length,
    );
  }
}
