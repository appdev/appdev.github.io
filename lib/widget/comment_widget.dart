import 'package:flutter/material.dart';
import 'package:issue_blog/utils/ui_util.dart';
import 'package:issue_blog/widget/markdown_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key key, @required this.comment}) : super(key: key);

  final Map comment;

  @override
  Widget build(BuildContext context) {
    return UIUtil.isPhoneStyle(context)
        ? Card(
            elevation: 8,
            margin: EdgeInsets.all(8),
            child: buildPostContent(),
          )
        : Container(
            padding: EdgeInsets.all(1.5),
            child: buildPostContent(),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color.fromARGB(255, 238, 238, 238), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
          );
  }

  Widget buildPostContent() {
    return Column(
      children: [
        Container(
          child: ListTile(
            leading: ClipOval(
                child: FadeInImage.memoryNetwork(
                    width: 40,
                    placeholder: kTransparentImage,
                    image: comment['user']['avatar_url'])),
            title: Text(comment['user']['login']),
            trailing: Text(DateTime.tryParse(comment['created_at'])
                .toString()
                .substring(0, "yyyy-MM-dd HH:mm".length)),
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 249, 250, 252),
            border: Border(bottom: BorderSide(color: Color.fromARGB(255, 238, 238, 238))),
          ),
        ),
        Padding(
          child: MarkdownWidget(markdown: comment['body']),
          padding: EdgeInsets.all(10),
        ),
      ],
    );
  }
}
