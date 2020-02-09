import 'package:app_comments/add_type.dart';
import 'package:app_comments/comment.dart';
import 'package:flutter/material.dart';

class AddService with ChangeNotifier{
  AddType addType;
  Comment comment;
  Comment showComment;

  AddService() {
    addType = AddType.New;
    comment = Comment.createNew();
  }  

  void edit(Comment editComment) {
    comment = editComment;
    showComment = editComment;
    addType = AddType.Edit;
    notifyListeners();
  }

  void reply(Comment replyComment) {
    comment = Comment.createNew(parentId: replyComment.id);
    showComment = replyComment;
    addType = AddType.Reply;
    notifyListeners();
  }

  void newAdd() {
    comment = Comment.createNew();
    addType = AddType.New;
    notifyListeners();
  }
}