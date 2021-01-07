import 'package:Burn/globals/global.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final double width, heigth, elevation, fontSize;
  final String text;
  final BorderRadius radius;

  final Color textColor, backgroundColor;
  final Function onPressed;
  final bool bold;

  const RoundedButton({
    Key key,
    @required this.bold,
    @required this.width,
    @required this.heigth,
    @required this.elevation,
    @required this.text,
    @required this.radius,
    @required this.fontSize,
    @required this.textColor,
    @required this.backgroundColor,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth,
      width: width,
      child: RaisedButton(
        elevation: elevation,
        color: backgroundColor,
        child: Text(
          text,
          style: textText(
            fontSize: fontSize,
            color: textColor,
            bold: bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: textColor),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
