import 'package:app_comments/comment.dart';
import 'package:app_comments/comment_widget.dart';
import 'package:flutter/material.dart';

class CommentsWidget extends StatelessWidget {
  final List<Comment> list;
  final int level;

  CommentsWidget(this.list, this.level);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: level != 0 ? EdgeInsets.only(left: 24) : EdgeInsets.all(0),
      child: ListView.builder(
        //semanticChildCount: list.length+2,
        shrinkWrap: level != 0,
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          return CommentWidget(list[index], level);
        },
      ),
    );
  }
}
