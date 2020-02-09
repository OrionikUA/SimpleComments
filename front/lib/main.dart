import 'package:app_comments/add_service.dart';
import 'package:app_comments/comments_service.dart';
import 'package:app_comments/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        child: MainPage(),
        providers: [
          ChangeNotifierProvider(create: (_) => CommentsService()),
          ChangeNotifierProvider(create: (_) => AddService()),
        ],
      ),
    );
  }
}
