import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/comment.dart';
import 'services/comments_service.dart';
import 'widgets/add_widget.dart';
import 'widgets/comments_widget.dart';
import 'widgets/footer.dart';
import 'widgets/statistics.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var futureList =
        Provider.of<CommentsService>(context, listen: true).getAllComments(); //CommentsService().getAllComments();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 42,
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage('assets/rect815.png'),
              ),
              SizedBox(
                width: 8,
              ),
              Statistics(),
            ],
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
                  print(list);
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
