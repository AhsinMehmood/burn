import 'package:Burn/globals/global.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key key}) : super(key: key);

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
              'Community'.toUpperCase(),
              style: textText(
                  fontSize: 16, color: Colors.yellowAccent, bold: true),
            ),
          ),
        ))
      ],
    );
  }
}
