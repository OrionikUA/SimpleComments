import 'package:flutter/material.dart';

import '../models/comment.dart';
import 'comment_widget.dart';

class CommentsWidget extends StatelessWidget {
  final List<Comment> list;
  final int level;

  CommentsWidget(this.list, this.level);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: level != 0 ? EdgeInsets.only(left: 24) : EdgeInsets.all(0),
      child: ListView.builder(        
        shrinkWrap: level != 0,
        itemCount: list.length + (level == 0 ? 1 : 0),
        itemBuilder: (ctx, index) {
          if (index >= list.length) return SizedBox(height: 190,);
          return CommentWidget(list[index], level);
        },
      ),
    );
  }
}
