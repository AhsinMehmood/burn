import 'package:Burn/globals/global.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomColors {
  static const kLightPinkColor = Color(0xffF3BBEC);
  static const kYellowColor = Color(0xffF3AA26);
  static const kCyanColor = Color(0xff0eaeb4);
  static const kPurpleColor = Color(0xff533DC6);
  static const kPrimaryColor = Color(0xff39439f);
  static const kBackgroundColor = Color(0xffF3F3F3);
  static const kLightColor = Color(0xffc4bbcc);
}

class WeeklyBarChartWidget extends StatelessWidget {
  final List<int> weeklyData;
  final double maximumValueOnYAxis;
  WeeklyBarChartWidget({this.weeklyData, this.maximumValueOnYAxis});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 0,
          child: Container(
            margin: EdgeInsets.only(top: 15.0),
            child: BarChart(
                mainBarData() // All the code for bar chart return from this function!
                ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        y: y,
        colors: [Colors.black], // Color of the bar which is filled
        width: 10.0,
        backDrawRodData: BackgroundBarChartRodData(
            show: true,
            colors: [Colors.black.withOpacity(0.2)],
            y: maximumValueOnYAxis // background max value.
            ),
      )
    ]);
  }

  // Complete list of bars returns from here.
  List<BarChartGroupData> showingGroups() {
    return List.generate(weeklyData.length, (index) {
      return makeGroupData(index,
          weeklyData[index].toDouble()); // This function will return the Bar.
    });
  }

  FlTitlesData _buildAxes() {
    return FlTitlesData(
        show: true,
        leftTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return textText(
                      fontSize: 12, color: Colors.black, bold: true);
                case 1:
                  return textText(
                      fontSize: 12, color: Colors.black, bold: true);
                case 2:
                  return textText(
                      fontSize: 12, color: Colors.black, bold: true);
                case 3:
                  return textText(
                      fontSize: 12, color: Colors.black, bold: true);
                case 4:
                  return textText(
                      fontSize: 12, color: Colors.black, bold: true);
                case 5:
                  return textText(
                      fontSize: 12, color: Colors.black, bold: true);

                default:
                  return textText(
                      fontSize: 12, color: Colors.black, bold: true);
              }
            },

            // textStyle:
            margin: 12, // space from bars starting position
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'Week 1';
                case 1:
                  return 'Week 2';
                case 2:
                  return 'Week 3';
                case 3:
                  return 'Week 4';
                case 4:
                  return 'Week 5';
                case 5:
                  return 'Week 6';

                default:
                  return '';
              }
            }));
    // This runs from 0 to length of list. In this case 0 - 6
  }

  BarChartData mainBarData() {
    return BarChartData(
      maxY: maximumValueOnYAxis,
      borderData: FlBorderData(
        show: false,
      ),

      groupsSpace: 50,
      titlesData: _buildAxes(), // To build x and y axis.
      alignment: BarChartAlignment.center, // To put it in center
      barGroups: showingGroups(), // This function would draw the actual bars!
    );
  }
}
