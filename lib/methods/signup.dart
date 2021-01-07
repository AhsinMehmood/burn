import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/global.dart';
import 'package:Burn/screens/pickout_workout_place.dart';
import 'package:Burn/screens/tabs_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterWithEmailPassword {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage;
  Future<void> register(
      email, password, firsName, lastName, BuildContext context) async {
    try {
      final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (authResult.additionalUserInfo.isNewUser) {
        Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'userId': authResult.user.uid,
          'name': firsName,
          'email': email,
          'registationDate': DateTime.now().toIso8601String(),
          'password': password,
          'level': 1,
        }).then(
          (value) {
            Firestore.instance
                .collection('users')
                .document(authResult.user.uid)
                .collection('exercise')
                .document('beginner')
                .setData({
              'weeksCompleted': 1,
              'beginner': true,
              'fullBodyCompleted': 0,
              'lowerBody': 0,
              'uperAndCoreBody': 0,
              'week1': 0,
              'week2': 0,
              'week3': 0,
              'week4': 0,
              'week5': 0,
              'week6': 0,
            });
            Firestore.instance
                .collection('users')
                .document(authResult.user.uid)
                .collection('exercise')
                .document('interm')
                .setData({
              'weeksCompleted': 1,
              'interm': true,
              'fullBodyCompleted': 0,
              'lowerBody': 0,
              'uperAndCoreBody': 0,
              'week1': 0,
              'week2': 0,
              'week3': 0,
              'week4': 0,
              'week5': 0,
              'week6': 0,
            });
            Firestore.instance
                .collection('users')
                .document(authResult.user.uid)
                .collection('exercise')
                .document('advanced')
                .setData({
              'weeksCompleted': 1,
              'fullBodyCompleted': 0,
              'lowerBody': 0,
              'advanced': true,
              'uperAndCoreBody': 0,
              'week1': 0,
              'week2': 0,
              'week3': 0,
              'week4': 0,
              'week5': 0,
              'week6': 0,
            }).then((value) => Navigator.push(
                      context,
                      BouncyPageRoute(
                        widget: TabsScreen(),
                      ),
                    ));
          },
        );
        try {} catch (e) {
          print(e.toString());
        }
      } else {}
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Your password is too weak";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email is invalid";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "Email is already in use on different account";
          break;
        case "ERROR_INVALID_CREDENTIAL":
          errorMessage = "Your email is invalid";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      showFlushBar(context, 'Error Occured', errorMessage, Colors.red);
    }
  }
}
