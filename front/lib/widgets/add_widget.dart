
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/add_type.dart';
import '../services/add_service.dart';
import 'add_input_widget.dart';
import 'inner_add_widget.dart';

class AddWidget extends StatefulWidget {
  @override
  _AddWidgetState createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  @override
  Widget build(BuildContext context) {
    var addProvider = Provider.of<AddService>(context, listen: true);

    Widget commentWidget;
    if (addProvider.addType == AddType.New) {
      commentWidget = SizedBox();
    } else {
      commentWidget = InnerAddWidget(addProvider.showComment, addProvider.addType);
    }

    return Container(
      height: 180,
      child: new Stack(
        children: [
          commentWidget,
          Align(
            alignment: Alignment.bottomCenter,
            child: AddInputWidget(
                addProvider.comment.clone(), addProvider.addType),
          ),
        ],
      ),
    );
  }
}
