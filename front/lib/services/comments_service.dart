import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/comment.dart';

class CommentsService with ChangeNotifier {
  Client _client = Client();

  static Map<String, String> _headers = {'content-type': 'application/json'};

  static const String _url = 'https://appcomments20200209081712.azurewebsites.net/api';
  static String get _commentsUrl => '$_url/comments';

  static String _commentsUrlWithId(int id) => '$_commentsUrl/$id';

  List<Comment> comments;

  Future<List<Comment>> getAllComments() async {
    if (comments != null) return comments;
    List<Comment> list = [];
    var response = await _client.get(_commentsUrl, headers: _headers);
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      for (Map<String, dynamic> obj in json) {
        list.add(Comment.fromJson(obj));
      }
      comments = list;
      return list;
    } else {
      return null;
    }
  }

  bool _changeChildFunc(Comment child, Comment obj) {
    if (child.id == obj.id) {
      obj.update(child);
      return true;
    }
    return false;
  }

  bool _insertChildFunc(Comment child, Comment obj) {
    if (obj.id == child.parentId) {
      obj.innerComments.add(child);
      return true;
    }
    return false;
  }

  bool _deleteChildFunc(Comment child, Comment obj) {
    if (obj.id == child.parentId) {
      obj.innerComments.removeWhere((element) => element.id == child.id);
      return true;
    }
    return false;
  }

  bool _editChild(Comment child, List<Comment> innerList,
      bool Function(Comment, Comment) func) {
    for (var obj in innerList) {
      if (func(child, obj)) {
        return true;
      }
      if (_editChild(child, obj.innerComments, func)) {
        return true;
      }
    }
    return false;
  }

  Future<Comment> createComment(String user, String description, bool isLike,
      {int parentId}) async {
    var comment = Comment.create(user, description, isLike, parentId: parentId);
    var json = jsonEncode(comment.toJson());
    var response =
        await _client.post(_commentsUrl, headers: _headers, body: json);
    if (response.statusCode == 200) {
      Map<String, dynamic> obj = jsonDecode(response.body);
      var newComment = Comment.fromJson(obj);
      if (newComment.parentId != null) {
        _editChild(newComment, comments, _insertChildFunc);
      } else {
        comments.add(newComment);
      }
      notifyListeners();
      return newComment;
    } else {
      return null;
    }
  }

  Future<bool> deleteComment(Comment comment) async {
    var response =
        await _client.delete(_commentsUrlWithId(comment.id), headers: _headers);
    if (response.statusCode == 200) {
      if (comment.parentId != null) {
        _editChild(comment, comments, _deleteChildFunc);
      } else {
        comments.removeWhere((element) => element.id == comment.id);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<Comment> changeComment(Comment comment) async {
    var json = jsonEncode(comment.toJson());
    var response = await _client.put(_commentsUrlWithId(comment.id),
        headers: _headers, body: json);
    if (response.statusCode == 200) {
      Map<String, dynamic> obj = jsonDecode(response.body);
      var newComment = Comment.fromJson(obj);
      _editChild(newComment, comments, _changeChildFunc);
      notifyListeners();
      return newComment;
    } else {
      return null;
    }
  }
}
