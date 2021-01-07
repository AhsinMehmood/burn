import 'package:Burn/data_models.dart/stretches_data.dart';
import 'package:Burn/exercises/stretches.dart';
import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/global.dart';
import 'package:Burn/screens/do_execsie.dart';
import 'package:Burn/screens/rounded_widget.dart';
import 'package:flutter/material.dart';

final StrexhesData dataClass = StrexhesData();

class ReadyToStretch extends StatelessWidget {
  final int level;
  final int workoutType;
  final int week;
  final exercise;
  const ReadyToStretch(
      {Key key,
      @required this.level,
      @required this.exercise,
      @required this.workoutType,
      @required this.week})
      : super(key: key);
  get stretchType {
    switch (workoutType) {
      case 1:
        return dataClass.fullBodyStrectchData;

        break;
      case 2:
        return dataClass.lowerBodyStrectchData;

        break;
      case 3:
        return dataClass.upperCoreBodyStrectchData;

        break;
      default:
        return dataClass.fullBodyStrectchData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        SafeArea(
          //   child: WillPopScope(
          // onWillPop: () {
          //   return Navigator.maybePop(context);
          // },
          child: Scaffold(
            appBar: AppBar(
                // leading: Container(),

                ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ready to Stretch?',
                  style:
                      textText(fontSize: 25, color: Colors.yellow, bold: true),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: RoundedButton(
                      bold: true,
                      width: MediaQuery.of(context).size.width * 0.6,
                      heigth: 40,
                      elevation: 0.0,
                      text: 'Yes'.toUpperCase(),
                      radius: BorderRadius.circular(10),
                      fontSize: 18,
                      textColor: Colors.black,
                      backgroundColor: Colors.yellow,
                      onPressed: () {
                        Navigator.push(
                            context,
                            BouncyPageRoute(
                                widget: DoExercise(
                              workoutData: stretchType,
                              exercise: exercise,
                            )));
                        // Navigator.push(
                        //     context,
                        //     BouncyPageRoute(
                        //         widget: Streches(
                        //       week: week,
                        //       level: level,
                        //       workoutType: workoutType,
                        //       exercise: exercise,
                        //     )));
                      }),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
