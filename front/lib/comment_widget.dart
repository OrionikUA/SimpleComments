import 'package:app_comments/add_service.dart';
import 'package:app_comments/comment.dart';
import 'package:app_comments/comments_service.dart';
import 'package:app_comments/comments_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final int level;

  int get nextLevel => level + 1;

  CommentWidget(this.comment, this.level);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _isExpanded = true;

  String _printDate(DateTime date) {
    return '${date.hour}:${date.minute} ${date.day}/${date.month}/${date.year}';
  }

  Widget _state() {
    if (widget.comment.isLike) {
      return Icon(
        Icons.thumb_up,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.thumb_down,
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          child: Card(
            elevation: 12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        Provider.of<AddService>(context, listen: false)
                            .edit(widget.comment);
                      }),
                  width: 80,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: <Widget>[
                          _state(),
                          SizedBox(
                            width: 8,
                          ),
                          Text(widget.comment.name),
                          SizedBox(
                            width: 8,
                          ),
                          Text(widget.comment.updateTime == null
                              ? _printDate(widget.comment.dateTime)
                              : _printDate(widget.comment.updateTime)),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            child: Icon(Icons.delete, color: Theme.of(context).accentColor, size: 16,),
                            onTap: () async {
                              Provider.of<CommentsService>(context, listen: false).deleteComment(widget.comment);
                            },
                          )
                        ],
                      ),
                      Text(widget.comment.comment),
                      Visibility(
                        maintainAnimation: true,
                        maintainSemantics: true,
                        maintainSize: true,
                        maintainState: true,
                        visible: widget.comment.innerComments.length > 0,
                        child: InkWell(
                          child: Text(
                            _isExpanded ? "Collapse" : "Expand",
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          onTap: () {
                            setState(() {
                              _isExpanded ^= true;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: IconButton(
                      icon: Icon(
                        Icons.reply,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: widget.level < 8
                          ? () {
                              Provider.of<AddService>(context, listen: false)
                                  .reply(widget.comment);
                            }
                          : null),
                  width: 80,
                ),
              ],
            ),
          ),
        ),
        _isExpanded &&
                widget.comment.innerComments != null &&
                widget.comment.innerComments.length > 0
            ? CommentsWidget(widget.comment.innerComments, widget.nextLevel)
            : SizedBox(),
      ],
    );
  }
}
