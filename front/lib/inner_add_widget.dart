import 'package:app_comments/add_service.dart';
import 'package:app_comments/add_type.dart';
import 'package:app_comments/comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InnerAddWidget extends StatelessWidget {
  final Comment comment;
  final AddType addType;

  InnerAddWidget(this.comment, this.addType);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      child: Card(
        color: Colors.orange[200],
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      child: Icon(Icons.close),
                      onTap: () {
                        Provider.of<AddService>(context, listen: false).newAdd();
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(comment.name),
                        Text(comment.comment),
                      ],
                    ),
                  ),
                  Icon(addType == AddType.Edit ? Icons.edit : Icons.reply),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
