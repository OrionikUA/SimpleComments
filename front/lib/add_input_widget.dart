import 'package:app_comments/add_service.dart';
import 'package:app_comments/add_type.dart';
import 'package:app_comments/comment.dart';
import 'package:app_comments/comments_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddInputWidget extends StatefulWidget {
  final Comment comment;
  final AddType addType;

  AddInputWidget(this.comment, this.addType);

  @override
  _AddInputWidgetState createState() => _AddInputWidgetState();
}

class _AddInputWidgetState extends State<AddInputWidget> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_nameControllerChanged);
    _descriptionController.addListener(_descriptionControllerChanged);
  }

  void _nameControllerChanged() {
    setState(() {
      widget.comment.name = _nameController.text;
    });
  }

  void _descriptionControllerChanged() {
    setState(() {
      widget.comment.comment = _descriptionController.text;
    });
  }

  bool _isCommentValid() {
    return widget.comment.name.isNotEmpty &&
        widget.comment.comment.isNotEmpty &&
        widget.comment.isLike != null;
  }

  Widget createLikeDisLikeWidget(bool isLike) {
    return Container(
      width: 48,
      child: IconButton(
        hoverColor: Colors.transparent,
        icon: Icon(
          isLike ? Icons.thumb_up : Icons.thumb_down,
          color: _likeDisLikeColor(isLike),
        ),
        onPressed: _likeDisLikeFunction(isLike),
      ),
    );
  }

  Color _likeDisLikeColor(bool isLike) {
    if (widget.comment.isLike == null || widget.comment.isLike != isLike)
      return Theme.of(context).accentColor;
    return isLike ? Colors.green : Colors.red;
  }

  Function _likeDisLikeFunction(bool isLike) {
    if (isLike == widget.comment.isLike) return null;
    return () {
      pressLikeDisLike(isLike);
    };
  }

  void pressLikeDisLike(bool isLike) {
    setState(() {
      widget.comment.isLike = isLike;
    });
  }

  Future createComment() async {
    var newComment = await Provider.of<CommentsService>(context, listen: false)
        .createComment(
            widget.comment.name, widget.comment.comment, widget.comment.isLike,
            parentId: widget.comment.parentId);
    Provider.of<AddService>(context, listen: false).newAdd();
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(newComment == null
            ? 'Comment has NOT been added!'
            : 'Comment has been added!')));
  }

  Future editComment() async {
    var newComment = await Provider.of<CommentsService>(context, listen: false)
        .changeComment(widget.comment);
    Provider.of<AddService>(context, listen: false).newAdd();
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(newComment == null
            ? 'Comment has NOT been edited!'
            : 'Comment has been edited!')));
  }

  @override
  Widget build(BuildContext context) {
    if (_nameController.text != widget.comment.name) {
      _nameController.text = widget.comment.name;
    }
    if (_descriptionController.text != widget.comment.comment) {
      _descriptionController.text = widget.comment.comment;
    }

    var isValid = _isCommentValid();

    return Container(
      height: 130,
      child: Card(
        elevation: 8,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(hintText: "Name"),
                          ),
                        ),
                        createLikeDisLikeWidget(true),
                        createLikeDisLikeWidget(false),
                      ],
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(hintText: "Comment"),
                    ),
                  ],
                ),
              ),
              Container(
                child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 48,
                      color: isValid
                          ? Theme.of(context).accentColor
                          : Theme.of(context).disabledColor,
                    ),
                    onPressed: isValid
                        ? () async {
                            if (widget.addType == AddType.Edit) {
                              await editComment();
                            } else {
                              await createComment();
                            }
                          }
                        : null),
                height: double.infinity,
                width: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
