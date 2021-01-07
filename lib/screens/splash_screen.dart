import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/themes.dart';
import 'package:Burn/screens/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'choose_login_sign_up.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  nextScreen() async {
    Future.delayed(Duration(seconds: 2)).then((value) {
      final user = Provider.of<FirebaseUser>(context);
      // fetchGif(AssetImage("images/animate.gif"));

      if (user != null) {
        Navigator.push(
          context,
          BouncyPageRoute(
            widget: TabsScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          BouncyPageRoute(
            widget: ChooseLoginSignUp(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getThemeData().primaryColor,
        ),
        Center(
          child: Image.asset(
            'assets/splash.gif',
            fit: BoxFit.fill,
            width: 250,
          ),
        ),
      ],
    );
  }
}
