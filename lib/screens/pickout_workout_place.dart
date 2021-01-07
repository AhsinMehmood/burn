import 'package:Burn/exercises/excercise_main_page.dart';
import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/global.dart';
import 'package:Burn/screens/rounded_widget.dart';
import 'package:flutter/material.dart';

class PickWorkoutPlace extends StatelessWidget {
  final int level;
  final int weeksCompleted;
  final int workoutType;
  const PickWorkoutPlace({
    Key key,
    @required this.workoutType,
    @required this.level,
    @required this.weeksCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Where are you training today?',
                      style: textText(
                          fontSize: 20, color: Colors.white, bold: true),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                      bold: true,
                      width: MediaQuery.of(context).size.width * 0.7,
                      heigth: 45,
                      elevation: 0.0,
                      text: 'HOME',
                      radius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          bottomRight: Radius.circular(22)),
                      fontSize: 16,
                      textColor: Colors.black,
                      backgroundColor: Colors.yellowAccent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            BouncyPageRoute(
                                widget: ExerciseMainPage(
                              level: level,
                              workoutType: workoutType,
                              place: 1,
                              week: weeksCompleted,
                            )));
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'OR',
                      style: textText(
                          fontSize: 20, color: Colors.white, bold: true),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                    bold: true,
                    width: MediaQuery.of(context).size.width * 0.7,
                    heigth: 45,
                    elevation: 0.0,
                    text: 'GYM',
                    radius: BorderRadius.only(
                      topRight: Radius.circular(22),
                      bottomLeft: Radius.circular(22),
                    ),
                    fontSize: 16,
                    textColor: Colors.black,
                    backgroundColor: Colors.yellowAccent,
                    onPressed: () {
                      Navigator.push(
                          context,
                          BouncyPageRoute(
                              widget: ExerciseMainPage(
                            level: level,
                            workoutType: workoutType,
                            place: 2,
                            week: weeksCompleted,
                          )));
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
