import 'package:flutter/material.dart';

import 'globalVar.dart';
import 'validator.dart';

class AllCoustomTheme {
  static ThemeData getThemeData() {
    if (isLight) {
      return buildLightTheme();
    } else {
      return buildDarkTheme();
    }
  }

  static Color getTextThemeColors() {
    if (isLight) {
      return Color(0xFF9E9E9E);
    } else {
      return Color(0xFF636466);
    }
  }

  static Color getBlackAndWhiteThemeColors() {
    if (isLight) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  static Color getReBlackAndWhiteThemeColors() {
    if (isLight) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    final txtName = 'Poppins';
    return base.copyWith(
      // ignore: deprecated_member_use
      body1: base.title?.copyWith(
        fontFamily: txtName,
        fontSize: 16,
        color: getBlackAndWhiteThemeColors(),
      ),
      // ignore: deprecated_member_use
      body2: base.title?.copyWith(
        fontFamily: txtName,
        fontSize: 14,
        color: getTextThemeColors(),
      ),
      // ignore: deprecated_member_use
      caption: base.title?.copyWith(
        fontFamily: txtName,
        fontSize: 12,
        color: getTextThemeColors(),
      ),
      // ignore: deprecated_member_use
      headline: base.title?.copyWith(
        fontFamily: txtName,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: getBlackAndWhiteThemeColors(),
      ),
      // ignore: deprecated_member_use
      subhead: base.title?.copyWith(
        fontFamily: txtName,
        fontSize: 22,
        color: getTextThemeColors(),
      ),
      // ignore: deprecated_member_use
      title: base.title?.copyWith(
        fontFamily: txtName,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: getBlackAndWhiteThemeColors(),
      ),
      // ignore: deprecated_member_use
      subtitle: base.title?.copyWith(
        fontFamily: txtName,
        fontSize: 16,
        color: getTextThemeColors(),
      ),
    );
  }

  static ThemeData buildDarkTheme() {
    return buildLightTheme();
  }

  static ThemeData buildLightTheme() {
    Color primaryColor = HexColor(primaryColorString);
    Color secondaryColor = HexColor(secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      cursorColor: primaryColor,
      scaffoldBackgroundColor: Colors.black,
      backgroundColor: const Color(0xFFFFFFFF),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
    );
  }
}
