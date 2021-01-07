import 'package:Burn/globals/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage;
  Future<void> passwordReset(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        showFlushBar(
            context,
            'Request Accepted',
            'We have sent you an email with instruction to reset your password please check your email box',
            Colors.green);
      });
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
