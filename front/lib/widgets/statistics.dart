import 'package:comments/services/comments_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Statistics extends StatefulWidget {
  @override
  SstatisticsState createState() => SstatisticsState();
}

class SstatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CommentsService>(context, listen: true);

    return Row(
      children: [
        Tooltip(
          child: Text(
            'Comments: ${provider.mainCommentsCount}',
            semanticsLabel: 'ddf',
          ),
          message: 'Number of first level comments',
        ),
        const SizedBox(width: 16),
        Tooltip(
          child: Text('Replies: ${provider.replyCommentsCount}'),
          message: 'Number of comments at all levels except the first',
        ),
        const SizedBox(width: 16),
        Tooltip(
          child: Row(
            children: [
              Icon(
                Icons.thumb_up,
                color: Colors.lightGreen,
              ),
              const SizedBox(width: 4),
              Text(provider.likeCommentsCount.toString()),
            ],
          ),
          message: 'Number of likes on the first level of comments',
        ),
        const SizedBox(width: 10),
        Tooltip(
                  child: Row(
            children: [
              Icon(
                Icons.thumb_down,
                color: Colors.red,
              ),
              const SizedBox(width: 4),
              Text(provider.dislikeCommentsCount.toString()),
            ],
          ),
          message: 'Number of dislikes on the first level of comments',
        ),
      ],
    );
  }
}
