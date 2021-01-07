import 'package:Burn/audios.dart';
import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/global.dart';
import 'package:Burn/screens/pickout_workout_place.dart';
import 'package:Burn/screens/rounded_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../gifs.dart';

class WorkoutScreen extends StatefulWidget {
  WorkoutScreen({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int levelIndex = 1;

  List<String> levelText = ['', 'BEGINNER', 'INTERMEDIATE', 'ADVANCED'];
  List<String> queryText = ['', 'beginner', 'interm', 'advanced'];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Stack(
      children: [
        Scaffold(
          body: NestedScrollView(
            physics: BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  stretch: true,
                  elevation: 00.0,
                  backgroundColor:
                      AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
                  leading: Container(),
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: InkWell(
                        onTap: () {
                          Navigator.push(
                              context, BouncyPageRoute(widget: MyApp()));

                          //ß audioPlayer.play('KNEE_PULLDOWNS.mp3');
                        },
                        child: Text(
                          'BURN',
                          style: GoogleFonts.crimsonPro(
                              fontSize: 32,
                              letterSpacing: -2.0,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      background: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        child: Image.asset(
                          'assets/starter.gif',
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ];
            },
            body: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .where('userId', isEqualTo: user.uid)
                  .snapshots(),
              builder: (context, mainUserSnap) {
                if (mainUserSnap.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final DocumentSnapshot mainUserDocument =
                    mainUserSnap.data.documents[0];
                return StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .document(user.uid)
                        .collection('exercise')
                        .where(queryText[mainUserDocument['level']],
                            isEqualTo: true)
                        .snapshots(),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (asyncSnapshot.data.documents.length == 0) {
                        return Container();
                      }
                      final DocumentSnapshot userExerciseData =
                          asyncSnapshot.data.documents[0];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RoundedButton(
                                      bold: true,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      heigth: 40,
                                      elevation: 0.0,
                                      text:
                                          '${levelText[mainUserDocument['level']]}',
                                      radius: BorderRadius.circular(12),
                                      fontSize: 16,
                                      textColor: Colors.black,
                                      backgroundColor: Colors.yellow,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context, state) {
                                                print(levelIndex);
                                                return Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Container(
                                                    padding: EdgeInsets.all(15),
                                                    height: 400,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(22),
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color:
                                                                Colors.yellow)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'Choose workout level',
                                                            style: textText(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .yellow,
                                                                bold: true),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 50,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Firestore.instance
                                                                .collection(
                                                                    'users')
                                                                .document(
                                                                    user.uid)
                                                                .updateData({
                                                              'level': 1,
                                                            });

                                                            Navigator.maybePop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'BEGINNER',
                                                                  style: textText(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .yellow,
                                                                      bold:
                                                                          true),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_outlined,
                                                                  color: Colors
                                                                      .yellow,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Firestore.instance
                                                                .collection(
                                                                    'users')
                                                                .document(
                                                                    user.uid)
                                                                .updateData({
                                                              'level': 2,
                                                            });
                                                            Navigator.maybePop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'INTERMEDIATE',
                                                                  style: textText(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .yellow,
                                                                      bold:
                                                                          true),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_outlined,
                                                                  color: Colors
                                                                      .yellow,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Firestore.instance
                                                                .collection(
                                                                    'users')
                                                                .document(
                                                                    user.uid)
                                                                .updateData({
                                                              'level': 3,
                                                            });
                                                            Navigator.maybePop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'ADVANCED',
                                                                  style: textText(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .yellow,
                                                                      bold:
                                                                          true),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_outlined,
                                                                  color: Colors
                                                                      .yellow,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      })
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // ActivityPieChart(),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    '',
                                    textAlign: TextAlign.start,
                                    style: textText(
                                      fontSize: 16,
                                      color: Colors.yellowAccent,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                circular(
                                    userExerciseData['fullBodyCompleted'] / 6,
                                    'Full Body'),
                                const SizedBox(
                                  width: 20,
                                ),
                                circular(userExerciseData['lowerBody'] / 6,
                                    'Lower Body'),
                                const SizedBox(
                                  width: 20,
                                ),
                                circular(
                                    userExerciseData['uperAndCoreBody'] / 6,
                                    'Upper and\n Core Body'),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'WEEKLY REPORT',
                                    textAlign: TextAlign.start,
                                    style: textText(
                                      fontSize: 16,
                                      color: Colors.yellowAccent,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.yellow,
                                      ),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        linedProgress(
                                            userExerciseData['week1'] / 9,
                                            'Week 1'),
                                        linedProgress(
                                            userExerciseData['week2'] / 9,
                                            'Week 2'),
                                        linedProgress(
                                            userExerciseData['week3'] / 9,
                                            'Week 3'),
                                        linedProgress(
                                            userExerciseData['week4'] / 9,
                                            'Week 4'),
                                        linedProgress(
                                            userExerciseData['week5'] / 9,
                                            'Week 5'),
                                        linedProgress(
                                            userExerciseData['week6'] / 9,
                                            'Week 6'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RoundedButton(
                                bold: true,
                                width: MediaQuery.of(context).size.width * 0.9,
                                heigth: 50,
                                elevation: 0.0,
                                text: 'Start Workout',
                                radius: BorderRadius.circular(10),
                                fontSize: 18,
                                textColor: Colors.black,
                                backgroundColor: Colors.yellow,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, state) {
                                          return Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              height: 400,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color: Colors.yellow)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'Choose workout',
                                                      style: textText(
                                                          fontSize: 16,
                                                          color: Colors.yellow,
                                                          bold: true),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 50,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.maybePop(
                                                              context)
                                                          .then((value) {
                                                        Navigator.push(
                                                            context,
                                                            BouncyPageRoute(
                                                                widget:
                                                                    PickWorkoutPlace(
                                                              workoutType: 1,
                                                              level:
                                                                  mainUserDocument[
                                                                      'level'],
                                                              weeksCompleted:
                                                                  userExerciseData[
                                                                      'weeksCompleted'],
                                                            )));
                                                      });
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            width: 2.0,
                                                            color: Colors.white,
                                                          )),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Full Body',
                                                            style: textText(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .yellow,
                                                                bold: true),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                            color:
                                                                Colors.yellow,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.maybePop(
                                                              context)
                                                          .then((value) {
                                                        Navigator.push(
                                                            context,
                                                            BouncyPageRoute(
                                                                widget:
                                                                    PickWorkoutPlace(
                                                              workoutType: 2,
                                                              level:
                                                                  mainUserDocument[
                                                                      'level'],
                                                              weeksCompleted:
                                                                  userExerciseData[
                                                                      'weeksCompleted'],
                                                            )));
                                                      });
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            width: 2.0,
                                                            color: Colors.white,
                                                          )),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Lower Body',
                                                            style: textText(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .yellow,
                                                                bold: true),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                            color:
                                                                Colors.yellow,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.maybePop(
                                                              context)
                                                          .then((value) {
                                                        Navigator.push(
                                                            context,
                                                            BouncyPageRoute(
                                                                widget:
                                                                    PickWorkoutPlace(
                                                              workoutType: 3,
                                                              level:
                                                                  mainUserDocument[
                                                                      'level'],
                                                              weeksCompleted:
                                                                  userExerciseData[
                                                                      'weeksCompleted'],
                                                            )));
                                                      });
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            width: 2.0,
                                                            color: Colors.white,
                                                          )),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Upper & Core Body',
                                                            style: textText(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .yellow,
                                                                bold: true),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                            color:
                                                                Colors.yellow,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                }),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
        )
      ],
    );
  }

  circular(percent, String text) {
    return new CircularPercentIndicator(
      radius: 120.0,
      animation: true,
      animationDuration: 1500,
      lineWidth: 10.0,
      percent: percent,
      center: new Text(
        text,
        style: textText(
          fontSize: 12,
          color: Colors.yellowAccent,
          bold: true,
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.yellow,
      progressColor: Colors.lightBlueAccent,
    );
  }

  linedProgress(percent, text) {
    return Column(
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: new LinearPercentIndicator(
            width: 100.0,
            animation: true,
            animationDuration: 1500,
            lineHeight: 8.0,
            percent: percent,
            backgroundColor: Colors.black.withOpacity(0.2),
            progressColor: Colors.black,
          ),
        ),
        Text(
          text,
          style: textText(fontSize: 10, color: Colors.black, bold: false),
        )
      ],
    );
  }

  // final List<int> weeklyData = [3, 6, 9, 1, 7, 0];
}
