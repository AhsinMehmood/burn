import 'package:Burn/globals/global.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        SafeArea(
            child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            leading: Container(),
            title: Text(
              'LeaderBoard'.toUpperCase(),
              style: textText(
                  fontSize: 16, color: Colors.yellowAccent, bold: true),
            ),
          ),
        ))
      ],
    );
  }
}
