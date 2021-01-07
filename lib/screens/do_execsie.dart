import 'dart:async';

import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/globalVar.dart';
import 'package:Burn/screens/after_stretch_exercise.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';
import '../audios.dart';

class DoExercise extends StatefulWidget {
  final workoutData;
  final exercise;
  DoExercise({Key key, @required this.workoutData, @required this.exercise})
      : super(key: key);

  @override
  _DoExerciseState createState() => _DoExerciseState();
}

class _DoExerciseState extends State<DoExercise> with TickerProviderStateMixin {
  Timer _timer;
  bool audioPlaying = false;
  int time = 0;
  String upcomingExerciseName = '';
  String upcomingExerciseImage = '';

  bool lastExercie = false;

  bool timeIsOn = false;
  String imageUrl = '';
  String audioLink = '';
  int workoutIndex = 0;

  play() async {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      if (time <= 1) {
        timer.cancel();
        print('$workoutIndex, workout index');

        setState(
          () {
            if (widget.workoutData.length - 1 == workoutIndex) {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return AfterStretchExercise(exercise: widget.exercise);
              }));
            } else {
              workoutIndex = workoutIndex + 1;
              audioLink = widget.workoutData[workoutIndex]['audioLink'];

              imageUrl = widget.workoutData[workoutIndex]['gifUrl'];
              time = widget.workoutData[workoutIndex]['time'];
              play();

              if (widget.workoutData.length - 1 == workoutIndex) {
                print('last exercise');
                lastExercie = true;
              } else {
                upcomingExerciseImage =
                    widget.workoutData[workoutIndex + 1]['gifUrl'];
                upcomingExerciseName =
                    widget.workoutData[workoutIndex + 1]['name'];
              }
            }
          },
        );
        // if (widget.workoutData.length - 1 != workoutIndex) {}
      } else {
        if (time < 6) {
          // audioPlayer.play("beep.mp3"); // assetsAudioPlayer.play();

          if (await Vibration.hasVibrator()) {
            Vibration.vibrate();
          } else {
            // showFlushBar(context, 'title', 'subTitle', Colors.red);
          }
        }

        setState(() {
          time = time - 1;
        });
      }
    });
  }

  String _getNumberAddZero(int number) {
    assert(number != null);
    if (number < 10) {
      return "0" + number.toString();
    }
    return number.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();

    print(widget.workoutData.length);
    time = widget.workoutData[workoutIndex]['time'];
    imageUrl = widget.workoutData[workoutIndex]['gifUrl'];
    audioLink = widget.workoutData[workoutIndex]['audioLink'];
    upcomingExerciseImage = widget.workoutData[workoutIndex + 1]['gifUrl'];
    upcomingExerciseName = widget.workoutData[workoutIndex + 1]['name'];
    // play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Container(),
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "00:" + _getNumberAddZero(time).toUpperCase(),
                        style: GoogleFonts.orbitron(
                            textStyle: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: AfterStretchExercise(
                                            exercise: widget.exercise)));
                              },
                              child: Material(
                                color: Colors.transparent,
                                elevation: 6.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(22),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    height: 500,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        '$upcomingExerciseName'.toUpperCase(),
                                        style: textText(
                                            fontSize: 20,
                                            color: Colors.white,
                                            bold: true),
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
}
