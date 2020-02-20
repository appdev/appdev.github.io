import 'package:issue_blog/datatransfer/event_bus.dart';

// 定义一个 top-level 变量，页面引入该文件后可以直接使用 bus
var callbackBus = new CallbackEventBus();

var streamBus = new StreamEventBus();

class LabelChangedEvent {
  String label;

  LabelChangedEvent(this.label);
}

class KeywordChangedEvent {
  String keyword;

  KeywordChangedEvent(this.keyword);
}

class PageChangedEvent {
  int page;

  PageChangedEvent(this.page);
}

class BlogContentChangeEvent {
  bool showList;
  int number;
  String postTitle;

  BlogContentChangeEvent({this.showList, this.number, this.postTitle = ""});

  @override
  String toString() {
    return 'BlogContentChangeEvent{showList: $showList, number: $number, postTitle: $postTitle}';
  }
}
