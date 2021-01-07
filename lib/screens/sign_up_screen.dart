import 'package:Burn/globals/bouncy_page.dart';
import 'package:Burn/globals/global.dart';
import 'package:Burn/globals/themes.dart';
import 'package:Burn/methods/signup.dart';
import 'package:Burn/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'pickout_workout_place.dart';
import 'rounded_widget.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  final FocusNode _emailFocus = FocusNode();
  String _password;

  final FocusNode _passwordFocus = FocusNode();
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool termsAndService = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AllCoustomTheme.getThemeData().primaryColor,
          child: Image.asset(
            'assets/option.gif',
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: Text(
                  'SIGN UP',
                  style: textText(
                      fontSize: 22, color: Colors.yellowAccent, bold: true),
                ),
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.yellowAccent,
                    ),
                    onPressed: () => Navigator.maybePop(context)),
                // backgroundColor:
                //     AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
              ),
              body: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      // FadeAnimation(
                      // delay: 0.3,
                      // child: AvatarGlow(
                      //     endRadius: 100,
                      //     glowColor: Colors.black26,
                      //     child: CircleAvatar(
                      //       backgroundColor:
                      //           AllCoustomTheme.getThemeData().primaryColor,
                      //       child: Image.asset(
                      //         'assets/logo_nova_2.png',
                      //         height: 125,
                      //         width: 125,
                      //       ),
                      //       radius: 80,
                      //     ))),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        delay: 0.6,
                        child: Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome to ',
                                textAlign: TextAlign.start,
                                style: textText(
                                    fontSize: 18,
                                    color: Colors.white,
                                    bold: false),
                              ),
                              Text(
                                ' $appName'.toUpperCase(),
                                textAlign: TextAlign.start,
                                style: textText(
                                    fontSize: 26,
                                    color: Colors.yellowAccent,
                                    bold: true),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      FadeAnimation(
                        delay: 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(
                                  width: 2.0, color: Colors.yellowAccent),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)),
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 20,
                                  ),
                                  height: 60,
                                  child: TextFormField(
                                    decoration: new InputDecoration(
                                      labelText: "Enter Full Name",
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      // suffixIcon: Icon(),
                                      labelStyle: textText(
                                          fontSize: 14,
                                          color: Colors.black,
                                          bold: false),
                                      // fillColor: Colors.white,

                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    controller: _firstNameController,
                                    keyboardType: TextInputType.name,
                                    style: textText(
                                        fontSize: 16,
                                        color: Colors.black,
                                        bold: false),
                                    textInputAction: TextInputAction.next,
                                    focusNode: _firstNameFocusNode,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(context,
                                          _firstNameFocusNode, _emailFocus);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Full Name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 20,
                                  ),
                                  height: 60,
                                  child: TextFormField(
                                    decoration: new InputDecoration(
                                      labelText: "Enter Email",
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      // suffixIcon: Icon(),
                                      labelStyle: textText(
                                          fontSize: 14,
                                          color: Colors.black,
                                          bold: false),
                                      // fillColor: Colors.white,

                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    controller: _emailAddressController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: textText(
                                        fontSize: 16,
                                        color: Colors.black,
                                        bold: false),
                                    textInputAction: TextInputAction.next,
                                    focusNode: _emailFocus,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(
                                          context, _emailFocus, _passwordFocus);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Email Address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 20,
                                  ),
                                  height: 60,
                                  child: TextFormField(
                                    decoration: new InputDecoration(
                                      labelText: "Enter Password",
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: Colors.black,
                                      ),
                                      // suffixIcon: Icon(),
                                      labelStyle: textText(
                                          fontSize: 14,
                                          color: Colors.black,
                                          bold: false),
                                      // fillColor: Colors.white,

                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    controller: _passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    style: textText(
                                        fontSize: 16,
                                        color: Colors.black,
                                        bold: false),
                                    textInputAction: TextInputAction.done,
                                    // focusNode: _emailFocus,
                                    // onFieldSubmitted: (term) {
                                    //   _fieldFocusChange(
                                    //       context, _emailFocus, _passwordFocus);
                                    // },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                FadeAnimation(
                                  delay: 1.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'By countinuing to use app, you accept our Terms of Service and Privacy Policy',
                                      style: textText(
                                          fontSize: 14,
                                          color: Colors.black,
                                          bold: true),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                loading == true
                                    ? CircularProgressIndicator()
                                    : FadeAnimation(
                                        delay: 1.2,
                                        child: RoundedButton(
                                            bold: true,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            heigth: 45,
                                            elevation: 12.0,
                                            text: 'SIGN UP',
                                            radius: BorderRadius.only(
                                                bottomLeft: Radius.circular(22),
                                                topRight: Radius.circular(22)),
                                            fontSize: 18,
                                            textColor: Colors.yellowAccent,
                                            backgroundColor:
                                                AllCoustomTheme.getThemeData()
                                                    .accentColor,
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                if (2 == 2) {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  await RegisterWithEmailPassword()
                                                      .register(
                                                          _emailAddressController
                                                              .text,
                                                          _passwordController
                                                              .text,
                                                          _firstNameController
                                                              .text,
                                                          _lastNameController
                                                              .text,
                                                          context)
                                                      .then((value) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                  });
                                                } else {
                                                  showFlushBar(
                                                      context,
                                                      'Error Occured',
                                                      'Please accept terms and conditions',
                                                      Colors.red);
                                                }
                                              }
                                            }),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // FadeAnimation(
                      //   delay: 1.5,
                      //   child: InkWell(
                      //     // onTap: () => Get.to(PasswordReset()),
                      //     child: Container(
                      //         margin:
                      //             EdgeInsets.only(bottom: 10, left: 0, right: 0),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               'Forgot Your Password? ',
                      //               style: textText(
                      //                   fontSize: 14,
                      //                   color: Colors.white,
                      //                   bold: false),
                      //             ),
                      //             Text(
                      //               ' RESET NOW',
                      //               style: textText(
                      //                   fontSize: 18,
                      //                   color: Colors.yellowAccent,
                      //                   bold: true),
                      //             ),
                      //           ],
                      //         )),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        delay: 1.8,
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context, BouncyPageRoute(widget: LoginScreen())),
                          child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 30, left: 30, right: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: textText(
                                        fontSize: 14,
                                        color: Colors.white,
                                        bold: false),
                                  ),
                                  Text(
                                    ' LOGIN NOW',
                                    style: textText(
                                        fontSize: 18,
                                        color: Colors.yellowAccent,
                                        bold: true),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
