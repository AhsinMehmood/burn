import 'package:flutter/material.dart';

import 'chart_activity.dart';
import 'weekly_bar_chart.dart';

class IndicatorWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;

  IndicatorWidget({this.color, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              title,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: TextStyle(
                  color: CustomColors.kLightColor, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
