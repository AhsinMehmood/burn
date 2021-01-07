import 'dart:async';
import 'dart:math';

import 'package:Burn/audios.dart';
import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/screens/rounded_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';

import 'readyToStretch.dart';

class WarmUp extends StatefulWidget {
  final int level;
  final int workoutType;
  final int week;
  final exercise;

  WarmUp({
    Key key,
    @required this.level,
    @required this.exercise,
    @required this.workoutType,
    @required this.week,
  }) : super(key: key);

  @override
  _WarmUpState createState() => _WarmUpState();
}

class _WarmUpState extends State<WarmUp> with SingleTickerProviderStateMixin {
  Timer _timer;
  int warmUpTime = 180;
  bool timeIsOn = false;
  double height = 0.0;
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '0${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0, minutes: 3),
    );
  }

  restAfterEveryExercise() async {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (warmUpTime <= 1) {
        timer.cancel();
        Navigator.push(
            context,
            BouncyPageRoute(
                widget: ReadyToStretch(
              workoutType: widget.workoutType,
              level: widget.level,
              week: widget.week,
              exercise: widget.exercise,
            )));

        print('time stop done');
      } else {
        if (warmUpTime < 10) {
          // audioPlayer.play('beep.mp3');

          if (await Vibration.hasVibrator()) {
            Vibration.vibrate();
          } else {}
        }

        setState(() {
          warmUpTime = warmUpTime - 1;
        });
      }
    });
  }

  GlobalKey stickyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(360 / 360),
                    child: AnimatedContainer(
                      key: stickyKey,
                      color: Colors.yellow,
                      height: timeIsOn
                          ? MediaQuery.of(context).size.height
                          : height,
                      duration: Duration(seconds: warmUpTime),
                    ),
                  ),
                ),
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
                                        timerString,
                                        style: GoogleFonts.orbitron(
                                            textStyle: TextStyle(
                                          fontSize: 50,
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
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton(
                              bold: true,
                              width: MediaQuery.of(context).size.width * 0.4,
                              heigth: 40,
                              elevation: 0.0,
                              text: controller.isAnimating
                                  ? 'Pause'.toUpperCase()
                                  : 'start'.toUpperCase(),
                              radius: BorderRadius.circular(22),
                              fontSize: 16,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              onPressed: () {
                                final RenderBox renderBoxRed =
                                    stickyKey.currentContext.findRenderObject();
                                final sizeRed = renderBoxRed.size.height;
                                print("SIZE of Red: $sizeRed");

                                setState(() {
                                  if (controller.isAnimating) {
                                    controller.stop();
                                    height = sizeRed;
                                    timeIsOn = false;
                                    //  startTimer();
                                    _timer.cancel();
                                    warmUpTime = warmUpTime;
                                  } else {
                                    restAfterEveryExercise();
                                    timeIsOn = true;
                                    // startTimer();
                                    controller.reverse(
                                        from: controller.value == 0.0
                                            ? 1.0
                                            : controller.value);
                                  }

                                  // if (controller.isAnimating) {
                                  //   controller.stop();
                                  //   //  startTimer();
                                  //   _timer.cancel();
                                  // } else {
                                  //   // startTimer();
                                  //   controller.reverse(
                                  //       from: controller.value == 0.0
                                  //           ? 1.0
                                  //           : controller.value);
                                  // }
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RoundedButton(
                              bold: true,
                              width: MediaQuery.of(context).size.width * 0.4,
                              heigth: 40,
                              elevation: 0.0,
                              text: 'Skip'.toUpperCase(),
                              radius: BorderRadius.circular(22),
                              fontSize: 16,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    BouncyPageRoute(
                                        widget: ReadyToStretch(
                                      workoutType: widget.workoutType,
                                      level: widget.level,
                                      week: widget.week,
                                      exercise: widget.exercise,
                                    )));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
