import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> novaIntroTitle = [
  'Welcome to myTRIBE',
  'Why we are?',
  'Why we are?',
];
List<String> novaIntroSubTitle = [
  'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
  'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
  'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
];

var appName = 'Burn';
var isLight = false;
TextStyle textText(
    {@required double fontSize, @required Color color, @required bool bold}) {
  FontWeight fontWeight;

  if (bold == true) {
    fontWeight = FontWeight.bold;
  } else {
    fontWeight = FontWeight.normal;
  }
  return GoogleFonts.nunitoSans(
      textStyle: TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  ));
}

String urlVerifySMS =
    'https://us-central1-mpl11-92ebf.cloudfunctions.net/verifySMS';
String urlSendSMS =
    'https://us-central1-mpl11-92ebf.cloudfunctions.net/sendSMS';
showFlushBar(BuildContext context, title, subTitle, Color color) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    reverseAnimationCurve: Curves.elasticInOut,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: color,
    isDismissible: true,
    duration: Duration(seconds: 3),
    titleText: Text(title,
        style: GoogleFonts.lato(
            textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: Colors.white,
        ))),
    messageText: Text(
      subTitle,
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.white,
      ),
    ),
  ).show(context);
}

var primaryColorString = '#000000';
var secondaryColorString = '#000000';
