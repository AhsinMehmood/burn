import 'package:Burn/globals/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseDetails extends StatelessWidget {
  final String exerciseName;
  final String exerciseImage;
  const ExerciseDetails({Key key, this.exerciseName, this.exerciseImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                exerciseName,
                style: textText(bold: true, color: Colors.white, fontSize: 18),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: exerciseImage,
                      fit: BoxFit.cover,
                      height: 450,
                      placeholder: (context, place) {
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Instructions'.toUpperCase(),
                    style: textText(
                      fontSize: 16,
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '● Stand with your feet apart and hands above your head.\n● Bring your knee up towards your chest whilst bringing your arms down either side of your leg.\n● Make sure you turn your body to face your knee the best you can.\n● Put your foot back on the floor, lift your arms above your head and turn your body back to the middle.\n● Repeat on the other side.'
                        .toUpperCase(),
                    style: textText(
                      fontSize: 14,
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
