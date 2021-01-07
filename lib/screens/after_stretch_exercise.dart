import 'dart:async';
import 'package:Burn/exercises/exercise_details.dart';
import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/globalVar.dart';
import 'package:Burn/screens/tabs_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';
import '../audios.dart';
import 'rounded_widget.dart';

class AfterStretchExercise extends StatefulWidget {
  final List exercise;
  AfterStretchExercise({Key key, @required this.exercise}) : super(key: key);

  @override
  _AfterStretchExerciseState createState() => _AfterStretchExerciseState();
}

class _AfterStretchExerciseState extends State<AfterStretchExercise> {
  Timer _timer;
  bool audioPlaying = false;
  int time = 0;
  String upcomingExerciseName = '';
  String upcomingExerciseImage = '';
  String exerciseName = '';

  bool lastExercie = false;

  String imageUrl = '';
  String audioLink = '';
  bool circuitOneDone = false;
  bool circuitTwoDone = false;
  bool circuitThreeDone = false;
  String tipLink = '';
  int exerciseCount = 1;
  bool rest = false;
  bool exerciseDone = false;
  int exerciseIndex = 0;
  int circuitExerciseCount = 0;
  int exerciseRestTime = 40;
  int duration =
      300; // 1000 milliseconds = 1 seconds // for saving time i am going to make it faster
  List get getCircuit1 {
    List finalExercise = [];
    finalExercise =
        widget.exercise.where((element) => element['circuit'] == 1).toList();
    finalExercise.sort((a, b) => a['index'].compareTo(b['index']));
    return finalExercise;
  }

  List get getCircuit2 {
    List finalExercise = [];
    finalExercise =
        widget.exercise.where((element) => element['circuit'] == 2).toList();
    finalExercise.sort((a, b) => a['index'].compareTo(b['index']));
    return finalExercise;
  }

  List get getCircuit3 {
    List finalExercise = [];
    finalExercise =
        widget.exercise.where((element) => element['circuit'] == 3).toList();
    finalExercise.sort((a, b) => a['index'].compareTo(b['index']));
    return finalExercise;
  }

  restAfterEveryExercise() async {
    _timer = Timer.periodic(Duration(milliseconds: 1200), (timer) async {
      if (exerciseRestTime <= 1) {
        timer.cancel();

        print('$circuitExerciseCount circuits completed');

        if (circuitExerciseCount == getCircuit1.length * 3) {
          print('circuit 1 done 3 times');
        } else {
          if (circuitOneDone) {
            if (circuitTwoDone) {
              // audioPlayer.play(audioLink);
              playCircuit3();
            } else {
              // audioPlayer.play(audioLink);
              playCircuit2();
            }
          } else {
            // audioPlayer.play(audioLink);
            play();
          }
        }

        exerciseRestTime = 40;
        // restAfterEveryExercise();
        setState(() {
          rest = false;
        });
      } else {
        if (exerciseRestTime < 8) {
          // assetsAudioPlayer.setVolume(1);
          // audioPlayer.play('beep.mp3');

          if (await Vibration.hasVibrator()) {
            Vibration.vibrate();
          } else {}
        }

        setState(() {
          exerciseRestTime = exerciseRestTime - 1;
        });
      }
    });
  }

  playCircuit3() async {
    _timer = Timer.periodic(Duration(milliseconds: 1200), (timer) async {
      if (time <= 1) {
        timer.cancel();

        setState(
          () {
            circuitExerciseCount = circuitExerciseCount + 1;

            if (exerciseCount == getCircuit3.length) {
              if (circuitExerciseCount == getCircuit3.length * 3) {
                circuitThreeDone = true;
                exerciseDone = true;
                // showSecondDialoge();
              } else {
                print(
                    'once all the execises in a circuit complted then this block will execute');
                // once all the execises in a circuit complted then this block will execute
                exerciseIndex = 0; // set the index to 0 again after 3 exercises
                exerciseCount =
                    1; // set exercise to 1 again so it can show the first exercise again
                audioLink = getCircuit3[exerciseIndex]['audioLink'];
                tipLink = getCircuit3[exerciseIndex]['audioTip'];
                imageUrl = getCircuit3[exerciseIndex]['gifUrl'];

                exerciseName = getCircuit3[exerciseIndex]['exerciseName'];

                time = getCircuit3[exerciseIndex]['exerciseTime'];
                // print('Exercise are done');

                restAfterEveryExercise();
                rest = true;
              }
            } else {
              // by default this block will be executed. it will handle current exercise to be shown
              exerciseIndex = exerciseIndex + 1;
              exerciseCount = exerciseCount + 1;

              print('$exerciseCount exercise count is $exerciseCount');
              audioLink = getCircuit3[exerciseIndex]['audioLink'];
              tipLink = getCircuit3[exerciseIndex]['audioTip'];
              imageUrl = getCircuit3[exerciseIndex]['gifUrl'];

              exerciseName = getCircuit3[exerciseIndex]['exerciseName'];

              time = getCircuit3[exerciseIndex]['exerciseTime'];

              if (exerciseCount == getCircuit3.length) {
                //when 3 exercises count  this block of code will handle next exercise to be shown

                exerciseIndex = 0;
                // exerciseCount = 1;

                upcomingExerciseImage = getCircuit3[exerciseIndex]['gifUrl'];

                upcomingExerciseName =
                    getCircuit3[exerciseIndex]['exerciseName'];

                restAfterEveryExercise();
                rest = true;
              } else {
                // this block will handle next exercise
                upcomingExerciseImage =
                    getCircuit3[exerciseIndex + 1]['gifUrl'];

                upcomingExerciseName =
                    getCircuit3[exerciseIndex + 1]['exerciseName'];

                restAfterEveryExercise();
                rest = true;
              }
            }
          },
        );
      } else {
        if (time < 8) {
          // audioPlayer.play("beep.mp3");
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate();
          } else {}
        }

        setState(() {
          time = time - 1;
        });
      }
    });
  }

  playCircuit2() async {
    _timer = Timer.periodic(Duration(milliseconds: 1200), (timer) async {
      if (time <= 1) {
        timer.cancel();

        setState(
          () {
            circuitExerciseCount = circuitExerciseCount + 1;

            if (exerciseCount == getCircuit2.length) {
              if (circuitExerciseCount == getCircuit2.length * 3) {
                circuitTwoDone = true;
                showSecondDialoge();
              } else {
                print(
                    'once all the execises in a circuit complted then this block will execute');
                // once all the execises in a circuit complted then this block will execute
                exerciseIndex = 0; // set the index to 0 again after 3 exercises
                exerciseCount =
                    1; // set exercise to 1 again so it can show the first exercise again
                audioLink = getCircuit2[exerciseIndex]['audioLink'];
                tipLink = getCircuit2[exerciseIndex]['audioTip'];
                imageUrl = getCircuit2[exerciseIndex]['gifUrl'];

                exerciseName = getCircuit2[exerciseIndex]['exerciseName'];

                time = getCircuit2[exerciseIndex]['exerciseTime'];
                // print('Exercise are done');

                restAfterEveryExercise();
                rest = true;
              }
            } else {
              // by default this block will be executed. it will handle current exercise to be shown
              exerciseIndex = exerciseIndex + 1;
              exerciseCount = exerciseCount + 1;

              print('$exerciseCount exercise count is $exerciseCount');
              audioLink = getCircuit2[exerciseIndex]['audioLink'];
              tipLink = getCircuit2[exerciseIndex]['audioTip'];
              imageUrl = getCircuit2[exerciseIndex]['gifUrl'];

              exerciseName = getCircuit2[exerciseIndex]['exerciseName'];

              time = getCircuit2[exerciseIndex]['exerciseTime'];

              if (exerciseCount == getCircuit2.length) {
                //when 3 exercises count  this block of code will handle next exercise to be shown

                exerciseIndex = 0;
                // exerciseCount = 1;

                upcomingExerciseImage = getCircuit2[exerciseIndex]['gifUrl'];

                upcomingExerciseName =
                    getCircuit2[exerciseIndex]['exerciseName'];

                restAfterEveryExercise();
                rest = true;
              } else {
                // this block will handle next exercise
                upcomingExerciseImage =
                    getCircuit2[exerciseIndex + 1]['gifUrl'];

                upcomingExerciseName =
                    getCircuit2[exerciseIndex + 1]['exerciseName'];

                restAfterEveryExercise();
                rest = true;
              }
            }
          },
        );
      } else {
        if (time < 8) {
          // audioPlayer.play("beep.mp3");
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate();
          } else {}
        }

        setState(() {
          time = time - 1;
        });
      }
    });
  }

  void play() async {
    _timer = Timer.periodic(Duration(milliseconds: 1200), (timer) async {
      if (time <= 1) {
        timer.cancel();

        setState(
          () {
            if (circuitExerciseCount == getCircuit1.length * 3) {
              // exerciseDone = true;
            } else {
              circuitExerciseCount = circuitExerciseCount + 1;

              if (exerciseCount == getCircuit1.length) {
                if (circuitExerciseCount == getCircuit1.length * 3) {
                  showFirstDialoge();
                } else {
                  print(
                      'once all the execises in a circuit complted then this block will execute');
                  // once all the execises in a circuit complted then this block will execute
                  exerciseIndex =
                      0; // set the index to 0 again after 3 exercises
                  exerciseCount =
                      1; // set exercise to 1 again so it can show the first exercise again
                  audioLink = getCircuit1[exerciseIndex]['audioLink'];
                  tipLink = getCircuit1[exerciseIndex]['audioTip'];
                  imageUrl = getCircuit1[exerciseIndex]['gifUrl'];

                  exerciseName = getCircuit1[exerciseIndex]['exerciseName'];

                  time = getCircuit1[exerciseIndex]['exerciseTime'];
                  // print('Exercise are done');

                  restAfterEveryExercise();
                  rest = true;
                }
              } else {
                // by default this block will be executed. it will handle current exercise to be shown
                exerciseIndex = exerciseIndex + 1;
                exerciseCount = exerciseCount + 1;

                print('$exerciseCount exercise count is $exerciseCount');
                audioLink = getCircuit1[exerciseIndex]['audioLink'];
                tipLink = getCircuit1[exerciseIndex]['audioTip'];
                imageUrl = getCircuit1[exerciseIndex]['gifUrl'];

                exerciseName = getCircuit1[exerciseIndex]['exerciseName'];

                time = getCircuit1[exerciseIndex]['exerciseTime'];

                if (exerciseCount == getCircuit1.length) {
                  //when 3 exercises count  this block of code will handle next exercise to be shown
                  print('exercise Count once Completed');
                  exerciseIndex = 0;
                  // exerciseCount = 1;

                  upcomingExerciseImage = getCircuit1[exerciseIndex]['gifUrl'];

                  upcomingExerciseName =
                      getCircuit1[exerciseIndex]['exerciseName'];

                  restAfterEveryExercise();
                  rest = true;
                } else {
                  // this block will handle next exercise
                  upcomingExerciseImage =
                      getCircuit1[exerciseIndex + 1]['gifUrl'];

                  upcomingExerciseName =
                      getCircuit1[exerciseIndex + 1]['exerciseName'];

                  restAfterEveryExercise();
                  rest = true;
                }
              }
            }
          },
        );
      } else {
        if (time < 10) {
          // audioPlayer.play("beep.mp3");
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate();
          } else {}
        }

        setState(() {
          time = time - 1;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    getCircuit1;
    getCircuit2;
    getCircuit3;

    print(getCircuit1.length);
    time = getCircuit1[exerciseIndex]['exerciseTime'];
    exerciseName = getCircuit1[exerciseIndex]['exerciseName'];
    imageUrl = getCircuit1[exerciseIndex]['gifUrl'];
    audioLink = getCircuit1[exerciseIndex]['audioLink'];
    tipLink = getCircuit1[exerciseIndex]['audioTip'];
    upcomingExerciseImage = getCircuit1[exerciseIndex + 1]['gifUrl'];
    upcomingExerciseName = getCircuit1[exerciseIndex + 1]['exerciseName'];
    // exerciseIndex = exerciseIndex + 1;
    // audioPlayer.play(audioLink);
    play();
  }

  String _getNumberAddZero(int number) {
    assert(number != null);
    if (number < 10) {
      return "0" + number.toString();
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return rest
        ? Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   elevation: 0.0,
            //   leading: Container,
            // ),
            backgroundColor: Colors.white10,
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '00:' +
                                            _getNumberAddZero(exerciseRestTime),
                                        style: GoogleFonts.orbitron(
                                            textStyle: TextStyle(
                                          fontSize: 60,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      lastExercie
                          ? Container()
                          : Container(
                              child: Column(children: [
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Next Exercise'.toUpperCase(),
                                        style: textText(
                                            fontSize: 18,
                                            color: Colors.yellow,
                                            bold: true),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        '$exerciseName'.toUpperCase(),
                                        style: textText(
                                            fontSize: 20,
                                            color: Colors.white,
                                            bold: true),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  BouncyPageRoute(
                                    widget: ExerciseDetails(
                                      exerciseImage: imageUrl,
                                      exerciseName: exerciseName.toUpperCase(),
                                    ),
                                  ),
                                );
                              },
                              child: Material(
                                color: Colors.transparent,
                                elevation: 6.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(22),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ))
        : exerciseDone
            ? Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Congratulations!\nYou have completed today\'s Full Body Workout and got 100 Points'
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: textText(
                              fontSize: 18, color: Colors.white, bold: true),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RoundedButton(
                            bold: true,
                            width: MediaQuery.of(context).size.width * 0.6,
                            heigth: 50,
                            elevation: 0.0,
                            text: 'Go Back to Home'.toUpperCase(),
                            radius: BorderRadius.circular(22),
                            fontSize: 16,
                            textColor: Colors.black,
                            backgroundColor: Colors.yellow,
                            onPressed: () {
                              Navigator.push(context,
                                  BouncyPageRoute(widget: TabsScreen()));
                            })
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  elevation: 0.0,
                  title: Text(
                    '00:'.toUpperCase() + _getNumberAddZero(time),
                    style: GoogleFonts.orbitron(
                        textStyle: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                  ),
                  leading: Padding(
                    padding: EdgeInsets.all(15),
                    // child: InkWell(
                    //   onTap: () {
                    //     audioPlayer.play(tipLink);
                    //   },
                    //   child: Icon(
                    //     Icons.mic_rounded,
                    //     size: 30,
                    //   ),
                    // ),
                  ),
                  // actions: [
                  //   audioPlaying
                  //       ? Container(
                  //           height: 10,
                  //           width: 10,
                  //           child: CircularProgressIndicator(
                  //             backgroundColor: Colors.white,
                  //           ),
                  //         )
                  //       : InkWell(
                  //           onTap: () async {
                  //             // showFirstDialoge();
                  //             audioPlayer.play(audioLink);
                  //           },
                  //           child: Padding(
                  //             padding: EdgeInsets.all(15),
                  //             child: Icon(
                  //               Icons.audiotrack_rounded,
                  //               size: 30,
                  //             ),
                  //           ),
                  //         ),
                  // ],
                ),
                backgroundColor: Colors.white10,
                body: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Align(
                            //   alignment: Alignment.topCenter,
                            //   child: Text(
                            //     exerciseName.toUpperCase(),
                            //     style: textText(
                            //         fontSize: 30,
                            //         color: Colors.white,
                            //         bold: false),
                            //   ),
                            // ),
                            Container(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        BouncyPageRoute(
                                          widget: ExerciseDetails(
                                            exerciseImage: imageUrl,
                                            exerciseName:
                                                exerciseName.toUpperCase(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 6.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(22),
                                        child: CachedNetworkImage(
                                          imageUrl: imageUrl,
                                          height: 500,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            lastExercie
                                ? Container()
                                : Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                'Next Exercise'.toUpperCase(),
                                                style: textText(
                                                    fontSize: 18,
                                                    color: Colors.yellow,
                                                    bold: true),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  rest = true;
                                                });
                                              },
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  '$upcomingExerciseName'
                                                      .toUpperCase(),
                                                  style: textText(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      bold: true),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
  }

  showFirstDialoge() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: Dialog(
          backgroundColor: Colors.black,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Circuit One is Completed'.toUpperCase(),
                    style: textText(
                      fontSize: 16,
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Circuit Two'.toUpperCase(),
                    style: textText(
                      fontSize: 16,
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: getCircuit2.length,
                      itemBuilder: (context, index) {
                        final excercise = getCircuit2[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () => Navigator.push(
                                context,
                                BouncyPageRoute(
                                    widget: ExerciseDetails(
                                  exerciseName:
                                      excercise['exerciseName'].toUpperCase(),
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
                  RaisedButton(
                      color: Colors.white,
                      child: Text(
                        'Start'.toUpperCase(),
                        style: textText(
                            fontSize: 16, color: Colors.black, bold: true),
                      ),
                      onPressed: () {
                        Navigator.maybePop(context);
                        setState(() {
                          circuitOneDone = true;
                          circuitExerciseCount = 0;
                          exerciseIndex = -1;
                          exerciseCount = 0;
                        });
                        print(exerciseIndex);
                        playCircuit2();
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  showSecondDialoge() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: Dialog(
          backgroundColor: Colors.black,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Circuit Two is Completed'.toUpperCase(),
                    style: textText(
                      fontSize: 16,
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Circuit Three'.toUpperCase(),
                    style: textText(
                      fontSize: 16,
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: getCircuit3.length,
                      itemBuilder: (context, index) {
                        final excercise = getCircuit3[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () => Navigator.push(
                                context,
                                BouncyPageRoute(
                                    widget: ExerciseDetails(
                                  exerciseName:
                                      excercise['exerciseName'].toUpperCase(),
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
                  RaisedButton(
                      color: Colors.white,
                      child: Text(
                        'Start'.toUpperCase(),
                        style: textText(
                            fontSize: 16, color: Colors.black, bold: true),
                      ),
                      onPressed: () {
                        Navigator.maybePop(context);
                        setState(() {
                          circuitOneDone = true;
                          circuitExerciseCount = 0;
                          exerciseIndex = -1;
                          exerciseCount = 0;
                        });
                        print(exerciseIndex);
                        playCircuit3();
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
