import 'package:app_comments/add_widget.dart';
import 'package:app_comments/comment.dart';
import 'package:app_comments/comments_service.dart';
import 'package:app_comments/comments_widget.dart';
import 'package:app_comments/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var futureList = Provider.of<CommentsService>(context, listen: true)
        .getAllComments(); //CommentsService().getAllComments();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 42,
          child: Image(
            image: AssetImage('assets/rect815.png'),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              builder: (ctx, sns) {
                if (sns.connectionState == ConnectionState.done) {
                  List<Comment> list = sns.data;
                  return Stack(
                    children: [
                      CommentsWidget(list, 0),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: AddWidget(),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("Waiting"),
                  );
                }
              },
              future: futureList,
            ),
          ),
          Container(
            height: 60,
            child: Footer(),
          ),
        ],
      ),
    );
  }
}
