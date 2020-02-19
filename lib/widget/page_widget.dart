import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/datatransfer/events.dart';
import 'package:issue_blog/utils/base_state.dart';
import 'package:issue_blog/utils/hex_color.dart';
import 'package:provider/provider.dart';

class PageWidget extends StatefulWidget {
  PageWidget({Key key}) : super(key: key);

  _PageWidgetState createState() => _PageWidgetState();
}

class _PageWidgetState extends BaseState<PageWidget> {
  TextEditingController _pageController;
  FocusNode _focusNode;

  _PageWidgetState() {
    _pageController = addAndGetChangeNotifier(TextEditingController(text: '1'));
    _focusNode = addAndGetChangeNotifier(FocusNode());
  }

  @override
  void initState() {
    super.initState();
    addSubscription(streamBus.on<LabelChangedEvent>().listen((event) {
      _pageController.text = '1';
      // 保存 page
      _savePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      borderSide: BorderSide(color: HexColor('#eeeeee')),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset('images/pre-page-hover.png'),
          onPressed: () {
            int page = int.tryParse(_pageController.text);
            if (page == null || page <= 1) {
              page = 2;
            }
            page--;
            _pageController.text = page.toString();
            notifyPageChanged(page);
          },
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 60,
          child: Consumer<PageModel>(builder: (context, pageModel, _) {
            _pageController.text = pageModel.page.toString();
            return RawKeyboardListener(
              focusNode: _focusNode,
              onKey: (RawKeyEvent event) {
                if (event is RawKeyUpEvent &&
                    event.data.logicalKey == LogicalKeyboardKey.enter &&
                    event.data is RawKeyEventDataWeb) {
                  _handleClickEnter();
                }
              },
              child: TextField(
                controller: _pageController,
                textInputAction: TextInputAction.search,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                onSubmitted: (text) {
                  _handleClickEnter();
                },
                cursorColor: Colors.lightBlue,
                style: TextStyle(fontSize: 14, color: HexColor('#4b595f')),
                decoration: InputDecoration(
                  hintText: '页码',
                  hintStyle: TextStyle(fontSize: 14, color: HexColor('#849aa4')),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            );
          }),
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Image.asset('images/next-page-hover.png'),
          onPressed: () {
            int page = int.tryParse(_pageController.text);
            if (page == null || page < 0) {
              page = 0;
            }
            page++;
            _pageController.text = page.toString();
            notifyPageChanged(page);
          },
        ),
      ],
    );
  }

  void _handleClickEnter() {
    int page = int.tryParse(_pageController.text);
    if (page == null || page <= 0) {
      page = 1;
      _pageController.text = page.toString();
    }
    _focusNode.unfocus();
    notifyPageChanged(page);
  }

  void notifyPageChanged(page) {
    // 保存 page
    _savePage();
    streamBus.emit(PageChangedEvent(page));
  }

  void _savePage() {
    Provider.of<PageModel>(context, listen: false).page = int.tryParse(_pageController.text);
  }
}
