import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var style = TextStyle(color: Colors.white);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Ihor Popkov', style: style,),
              Text('ihor.popkov@gmail.com', style: style,),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('2020', style: style,)],
          )
        ],
      ),
    );
  }
}
