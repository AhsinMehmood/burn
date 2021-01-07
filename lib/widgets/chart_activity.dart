import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator_widget.dart';
import 'weekly_bar_chart.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class ActivityPieChart extends StatefulWidget {
  @override
  _ActivityPieChartState createState() => _ActivityPieChartState();
}

class _ActivityPieChartState extends State<ActivityPieChart> {
  int _touchedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 25,
      child: Card(
        // color: Colors.red,
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 60,
              // Pie Chart is available in fl_chart package
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 50.0,
                  sectionsSpace: 0.0,

                  startDegreeOffset: 30,
                  // actual curves and data come from this function result.
                  sections: showingSections(),
                  // This is to make chart interactive when someone touch
                  pieTouchData: PieTouchData(
                    touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          _touchedIndex = -1;
                        } else {
                          _touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 3),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IndicatorWidget(
                      color: CustomColors.kPrimaryColor,
                      title: 'Full Body',
                      subtitle: '10 KM',
                    ),
                    IndicatorWidget(
                      color: CustomColors.kCyanColor,
                      // iconPath: 'assets/icons/bike.svg',
                      title: 'Lower Body',
                      subtitle: '10 KM',
                    ),
                    IndicatorWidget(
                      color: CustomColors.kLightPinkColor,
                      // iconPath: 'assets/icons/swimmer.svg',
                      title: 'Upper and Core',
                      subtitle: '10 KM',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Here we will show different type of graph on different scenario touch and non touch
  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == _touchedIndex;
      // Increase the radius of section when touched, we will see it in action in a minute
      final double radius = isTouched ? 30 : 20;

      // Ideally this data come from API and then returned, or you can modify it any way as per the data arranged in your app :)
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: CustomColors.kLightPinkColor,
              value: 33.33,
              title: '', // this cannot be left blank
              radius: radius);
        case 1:
          return PieChartSectionData(
              color: CustomColors.kPrimaryColor,
              value: 33.33,
              title: '', // this cannot be left blank
              radius: radius);
        case 2:
          return PieChartSectionData(
              color: CustomColors.kCyanColor,
              value: 33.33,
              title: '', // this cannot be left blank
              radius: radius);
        default:
          return null;
      }
    });
  }
}
