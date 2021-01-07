import 'package:Burn/data_models.dart/check_type.dart';
import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/global.dart';
import 'package:Burn/screens/rounded_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './exercise_details.dart';
import './warm_up.dart';

class ExerciseMainPage extends StatelessWidget {
  final int level;
  final int workoutType;
  final int week;
  final int place;

  ExerciseMainPage({
    Key key,
    @required this.place,
    @required this.level,
    @required this.week,
    @required this.workoutType,
  }) : super(key: key);

  String get mainExerciseText {
    switch (workoutType) {
      case 1:
        return 'Full Body Workout'.toUpperCase();
        break;
      case 2:
        return 'Lower Body Workout'.toUpperCase();
        break;
      case 3:
        return 'Upper & Core Body Workout'.toUpperCase();
        break;
      default:
        return 'Full Body Workout'.toUpperCase();
        break;
    }
  }

  String get mainExerciseTime {
    switch (workoutType) {
      case 1:
        return '35';
        break;
      case 2:
        return '30';
        break;
      case 3:
        return '30';
        break;
      default:
        return 'Full Body Workout';
        break;
    }
  }

  String get mainExerciseLevel {
    switch (level) {
      case 1:
        return 'BEGINNER'.toUpperCase();
        break;
      case 2:
        return 'INTERMEDIATE'.toUpperCase();
        break;
      case 3:
        return 'ADVANCED'.toUpperCase();
        break;
      default:
        return 'Full Body Workout';
        break;
    }
  }

  bool get activation {
    switch (workoutType) {
      case 1:
        return false;

        break;

      default:
        return true;
    }
  }

  List get getCircuit1 {
    List finalExercise = [];
    finalExercise = CheckWorkout()
        .getExercise(
          level: level,
          week: week,
          workoutType: workoutType,
          place: place,
        )
        .where((element) => element['circuit'] == 1)
        .toList();
    finalExercise.sort((a, b) => a['index'].compareTo(b['index']));
    return finalExercise;
  }

  List get getCircuit2 {
    List finalExercise = [];
    finalExercise = CheckWorkout()
        .getExercise(
          level: level,
          week: week,
          workoutType: workoutType,
          place: place,
        )
        .where((element) => element['circuit'] == 2)
        .toList();
    finalExercise.sort((a, b) => a['index'].compareTo(b['index']));
    return finalExercise;
  }

  List get getCircuit3 {
    List finalExercise = [];
    finalExercise = CheckWorkout()
        .getExercise(
          level: level,
          week: week,
          workoutType: workoutType,
          place: place,
        )
        .where((element) => element['circuit'] == 3)
        .toList();
    finalExercise.sort((a, b) => a['index'].compareTo(b['index']));
    return finalExercise;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        SafeArea(
          child: Scaffold(
            floatingActionButton: floaatingButton(context),
            body: NestedScrollView(
              physics: BouncingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: false,
                    leading: InkWell(
                        onTap: () {
                          Navigator.maybePop(context);
                        },
                        child: Icon(Icons.close)),
                    stretch: true,
                    elevation: 00.0,
                    backgroundColor:
                        AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
                    // leading: Container(),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // const SizedBox(
                          //   height: 200,
                          // ),
                          Text(
                            mainExerciseText,
                            style: GoogleFonts.crimsonPro(
                                fontSize: 18,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '$mainExerciseTime'.toUpperCase(),
                                    style: GoogleFonts.crimsonPro(
                                        fontSize: 12,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Minutes'.toUpperCase(),
                                    style: GoogleFonts.crimsonPro(
                                        fontSize: 12,
                                        color: Colors.yellow.withOpacity(0.6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '3'.toUpperCase(),
                                    style: GoogleFonts.crimsonPro(
                                        fontSize: 12,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Circuits'.toUpperCase(),
                                    style: GoogleFonts.crimsonPro(
                                        fontSize: 12,
                                        color: Colors.yellow.withOpacity(0.6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    mainExerciseLevel,
                                    style: GoogleFonts.crimsonPro(
                                        fontSize: 12,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'LEVEL'.toUpperCase(),
                                    style: GoogleFonts.crimsonPro(
                                        fontSize: 12,
                                        color: Colors.yellow.withOpacity(0.6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '$week'.toUpperCase(),
                                    style: GoogleFonts.crimsonPro(
                                        fontSize: 12,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'WEEK'.toUpperCase(),
                                    style: GoogleFonts.crimsonPro(
                                        fontSize: 12,
                                        color: Colors.yellow.withOpacity(0.6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Container(
                color: Colors.black,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Equipments'.toUpperCase(),
                              style: textText(
                                  fontSize: 18,
                                  color: Colors.yellow,
                                  bold: true),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // color: Colors.white,
                        height: 50,
                        child: ListView.builder(
                          itemCount: CheckWorkout()
                              .getEquipments(
                                level: level,
                                week: week,
                                workoutType: workoutType,
                                place: place,
                              )
                              .length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, index) {
                            final data = CheckWorkout().getEquipments(
                              level: level,
                              week: week,
                              workoutType: workoutType,
                              place: place,
                            )[index];
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ListTile(
                                tileColor: Colors.white,
                                title: Text(
                                  data['equipmetnName'].toUpperCase(),
                                  style: textText(
                                      fontSize: 16,
                                      color: Colors.black,
                                      bold: true),
                                ),
                                leading: CachedNetworkImage(
                                  imageUrl: data['equipmentImageUrl'],
                                  placeholder: (context, place) {
                                    return Container(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      activation
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Activation'.toUpperCase(),
                                    style: textText(
                                        fontSize: 18,
                                        color: Colors.yellow,
                                        bold: true),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      activation
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: CheckWorkout()
                                  .getActivations(
                                    level: level,
                                    week: week,
                                    workoutType: workoutType,
                                    place: place,
                                  )
                                  .length,
                              itemBuilder: (BuildContext context, index) {
                                final excercise = CheckWorkout().getActivations(
                                  level: level,
                                  week: week,
                                  workoutType: workoutType,
                                  place: place,
                                )[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: () => Navigator.push(
                                        context,
                                        BouncyPageRoute(
                                            widget: ExerciseDetails(
                                          exerciseName:
                                              excercise['exerciseName']
                                                  .toUpperCase(),
                                          exerciseImage:
                                              excercise['activationImageUrl'],
                                        ))),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            excercise['activationImageUrl'],
                                        placeholder: (context, place) {
                                          return CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                          );
                                        },
                                      ),
                                    ),
                                    title: Text(
                                      excercise['exerciseName'].toUpperCase(),
                                      style: textText(
                                          fontSize: 14,
                                          color: Colors.yellow,
                                          bold: true),
                                    ),
                                    subtitle: Text(
                                      ''.toString(),
                                      style: textText(
                                          fontSize: 12,
                                          color: Colors.yellow,
                                          bold: false),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_right_outlined,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                );
                              })
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Circuit 1'.toUpperCase(),
                              style: textText(
                                  fontSize: 18,
                                  color: Colors.yellow,
                                  bold: true),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: getCircuit1.length,
                          itemBuilder: (BuildContext context, index) {
                            final excercise = getCircuit1[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () => Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: ExerciseDetails(
                                      exerciseName: excercise['exerciseName']
                                          .toUpperCase(),
                                      exerciseImage: excercise['gifUrl'],
                                    ))),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: excercise['gifUrl'],
                                    placeholder: (context, place) {
                                      return CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      );
                                    },
                                  ),
                                ),
                                title: Text(
                                  excercise['exerciseName'].toUpperCase(),
                                  style: textText(
                                      fontSize: 14,
                                      color: Colors.yellow,
                                      bold: true),
                                ),
                                subtitle: Text(
                                  ''.toString(),
                                  style: textText(
                                      fontSize: 12,
                                      color: Colors.yellow,
                                      bold: false),
                                ),
                                trailing: Icon(
                                  Icons.arrow_right_outlined,
                                  color: Colors.yellow,
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Circuit 2'.toUpperCase(),
                              style: textText(
                                  fontSize: 18,
                                  color: Colors.yellow,
                                  bold: true),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: getCircuit2.length,
                          itemBuilder: (BuildContext context, index) {
                            final excercise = getCircuit2[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () => Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: ExerciseDetails(
                                      exerciseName: excercise['exerciseName']
                                          .toUpperCase(),
                                      exerciseImage: excercise['gifUrl'],
                                    ))),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: excercise['gifUrl'],
                                    placeholder: (context, place) {
                                      return CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      );
                                    },
                                  ),
                                ),
                                title: Text(
                                  excercise['exerciseName'].toUpperCase(),
                                  style: textText(
                                      fontSize: 14,
                                      color: Colors.yellow,
                                      bold: true),
                                ),
                                subtitle: Text(
                                  ''.toString(),
                                  style: textText(
                                      fontSize: 12,
                                      color: Colors.yellow,
                                      bold: false),
                                ),
                                trailing: Icon(
                                  Icons.arrow_right_outlined,
                                  color: Colors.yellow,
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Circuit 3'.toUpperCase(),
                              style: textText(
                                  fontSize: 18,
                                  color: Colors.yellow,
                                  bold: true),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: getCircuit3.length,
                          itemBuilder: (BuildContext context, index) {
                            final excercise = getCircuit3[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () => Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: ExerciseDetails(
                                      exerciseName: excercise['exerciseName']
                                          .toUpperCase(),
                                      exerciseImage: excercise['gifUrl'],
                                    ))),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: excercise['gifUrl'],
                                    placeholder: (context, place) {
                                      return CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      );
                                    },
                                  ),
                                ),
                                title: Text(
                                  excercise['exerciseName'].toUpperCase(),
                                  style: textText(
                                      fontSize: 14,
                                      color: Colors.yellow,
                                      bold: true),
                                ),
                                subtitle: Text(
                                  ''.toString(),
                                  style: textText(
                                      fontSize: 12,
                                      color: Colors.yellow,
                                      bold: false),
                                ),
                                trailing: Icon(
                                  Icons.arrow_right_outlined,
                                  color: Colors.yellow,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget floaatingButton(BuildContext context) {
    return RoundedButton(
        bold: true,
        width: MediaQuery.of(context).size.width * 0.6,
        heigth: 40,
        elevation: 0.0,
        text: 'START WARM UP'.toUpperCase(),
        radius: BorderRadius.circular(22),
        fontSize: 15,
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
                      height: 500,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(width: 1.0, color: Colors.yellow)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              'Please select one of the following options'
                                  .toUpperCase(),
                              style: textText(
                                  fontSize: 14,
                                  color: Colors.yellow,
                                  bold: true),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          InkWell(
                            onTap: () async {
                              FirebaseUser user =
                                  await FirebaseAuth.instance.currentUser();
                              print(user.uid);
                              Navigator.maybePop(context).then((value) {
                                Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: WarmUp(
                                      week: week,
                                      level: level,
                                      workoutType: workoutType,
                                      exercise: CheckWorkout().getExercise(
                                        level: level,
                                        week: week,
                                        workoutType: workoutType,
                                        place: place,
                                      ),
                                    )));
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.white,
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Treadmill'.toUpperCase(),
                                    style: textText(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        bold: true),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.yellow,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.maybePop(context).then((value) {
                                Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: WarmUp(
                                      week: week,
                                      level: level,
                                      workoutType: workoutType,
                                      exercise: CheckWorkout().getExercise(
                                        level: level,
                                        week: week,
                                        workoutType: workoutType,
                                        place: place,
                                      ),
                                    )));
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.white,
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Bike'.toUpperCase(),
                                    style: textText(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        bold: true),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.yellow,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.maybePop(context).then((value) {
                                Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: WarmUp(
                                      week: week,
                                      level: level,
                                      workoutType: workoutType,
                                      exercise: CheckWorkout().getExercise(
                                        level: level,
                                        week: week,
                                        workoutType: workoutType,
                                        place: place,
                                      ),
                                    )));
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.white,
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Skipping'.toUpperCase(),
                                    style: textText(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        bold: true),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.yellow,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.maybePop(context).then((value) {
                                Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: WarmUp(
                                      week: week,
                                      level: level,
                                      workoutType: workoutType,
                                      exercise: CheckWorkout().getExercise(
                                        level: level,
                                        week: week,
                                        workoutType: workoutType,
                                        place: place,
                                      ),
                                    )));
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.white,
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shuttle Runs'.toUpperCase(),
                                    style: textText(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        bold: true),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.yellow,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.maybePop(context).then((value) {
                                Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: WarmUp(
                                      week: week,
                                      level: level,
                                      workoutType: workoutType,
                                      exercise: CheckWorkout().getExercise(
                                        level: level,
                                        week: week,
                                        workoutType: workoutType,
                                        place: place,
                                      ),
                                    )));
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.white,
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cardio'.toUpperCase(),
                                    style: textText(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        bold: true),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.yellow,
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
        });
  }
}
