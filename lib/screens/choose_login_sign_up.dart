import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/global.dart';
import 'package:Burn/globals/globalVar.dart';
import 'package:Burn/globals/themes.dart';
import 'package:Burn/screens/login_screen.dart';
import 'package:Burn/screens/rounded_widget.dart';
import 'package:Burn/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseLoginSignUp extends StatefulWidget {
  const ChooseLoginSignUp({Key key}) : super(key: key);

  @override
  _ChooseLoginSignUpState createState() => _ChooseLoginSignUpState();
}

class _ChooseLoginSignUpState extends State<ChooseLoginSignUp> {
  PageController pageController = PageController(viewportFraction: 0.8);
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      int next = pageController.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AllCoustomTheme.getThemeData().primaryColor,
          child: Image.asset(
            'assets/starter.gif',
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/splash.png',
                        fit: BoxFit.fill,
                        width: 140,
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'BURN',
                        style: GoogleFonts.crimsonPro(
                            fontSize: 32,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      delay: 1.1,
                      child: Container(
                        height: 30,
                        child: Center(
                          child: PageIndicator(
                            layout: PageIndicatorLayout.DROP,
                            size: 10.0,
                            controller: pageController,
                            space: 3.0,
                            count: 3,
                            color: Colors.yellowAccent.withOpacity(0.5),
                            activeColor: Colors.yellowAccent,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.center,
            child: FadeAnimation(
              delay: 0.9,
              child: Container(
                height: 240,
                child: PageView.builder(
                  itemCount: novaIntroTitle.length,
                  physics: BouncingScrollPhysics(),
                  controller: pageController,
                  itemBuilder: (context, index) {
                    bool active = index == currentPage;

                    return pageViewBuilder(active, index);
                  },
                ),
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 70),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(
                    bold: true,
                    width: MediaQuery.of(context).size.width * 0.4,
                    heigth: 45,
                    elevation: 20.0,
                    text: 'Login'.toUpperCase(),
                    radius: BorderRadius.circular(12),
                    fontSize: 18,
                    textColor: Colors.black,
                    backgroundColor: Colors.yellowAccent,
                    onPressed: () => Navigator.push(
                      context,
                      BouncyPageRoute(
                        widget: LoginScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  RoundedButton(
                    bold: true,
                    width: MediaQuery.of(context).size.width * 0.4,
                    heigth: 45,
                    elevation: 20.0,
                    text: 'Sign Up'.toUpperCase(),
                    radius: BorderRadius.circular(12),
                    fontSize: 18,
                    textColor: Colors.black,
                    backgroundColor: Colors.yellowAccent,
                    onPressed: () => Navigator.push(
                      context,
                      BouncyPageRoute(
                        widget: SignUpScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  pageViewBuilder(bool active, int index) {
    final double top = active ? 40 : 70;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(top: top, bottom: 10, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black54,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Text(
            novaIntroSubTitle[index],
            textAlign: TextAlign.center,
            style: textText(fontSize: 18, color: Colors.white, bold: true),
          ),
        ),
      ),
    );
  }
}
