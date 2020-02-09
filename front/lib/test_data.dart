import 'package:app_comments/comment.dart';

class TestData {
  static List<Comment> list = [
    Comment(1, 'Ihor', DateTime.utc(2020, 1, 1, 12, 20, 32), 'Hello World 1', true),
    Comment(2, 'Oleh', DateTime.utc(2020, 2, 1, 12, 20, 32), 'Hello World 2', true, innerComments: [
      Comment(8, 'Ihor', DateTime.utc(2020, 2, 2, 12, 20, 32), "comment", true),
      Comment(8, 'Bohdan', DateTime.utc(2020, 2, 2, 13, 20, 32), "comment 2", false),
      Comment(8, 'Ihor', DateTime.utc(2020, 2, 2, 14, 20, 32), "comment 3", true),
      Comment(8, 'Oleh', DateTime.utc(2020, 2, 2, 15, 20, 32), "comment 4", false),
    ],),
    Comment(3, 'Ihor', DateTime.utc(2020, 3, 1, 12, 20, 32), 'Hello World 3', false),
    Comment(4, 'Oleh', DateTime.utc(2020, 4, 1, 12, 20, 32), 'Hello World 4', false),
    Comment(5, 'Bohdan', DateTime.utc(2020, 5, 1, 12, 20, 32), 'Hello World 5', false),
    Comment(6, 'Ihor', DateTime.utc(2020, 1, 6, 12, 20, 32), 'Hello World 6', true),
    Comment(7, 'Bohdan', DateTime.utc(2020, 7, 1, 12, 20, 32), 'Hello World 7', false),
  ]; 
}