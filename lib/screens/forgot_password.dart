import 'package:Burn/globals/global.dart';
import 'package:Burn/methods/forgot_password.dart';
import 'package:flutter/material.dart';

import 'rounded_widget.dart';

// ignore: must_be_immutable
class PasswordReset extends StatefulWidget {
  PasswordReset({Key key}) : super(key: key);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'assets/option.gif',
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
        FadeAnimation(
          delay: 0.5,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'PASSWORD RESET',
                style: textText(
                  fontSize: 16,
                  color: Colors.yellowAccent,
                  bold: true,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.yellowAccent,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeAnimation(
                      delay: 0.7,
                      child: Container(
                          margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                          child: Row(
                            children: [
                              Text(
                                'Forgot Your Password?',
                                style: textText(
                                    fontSize: 18,
                                    color: Colors.white,
                                    bold: false),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      delay: 0.9,
                      child: Container(
                          margin:
                              EdgeInsets.only(bottom: 30, left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No worry We\'ll Reset for you',
                                style: textText(
                                    fontSize: 16,
                                    color: Colors.white,
                                    bold: true),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    FadeAnimation(
                      delay: 1.1,
                      child: Container(
                        // padding: EdgeInsets.all(25),
                        margin: EdgeInsets.all(20),
                        child: FadeAnimation(
                          delay: 1.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            elevation: 6.0,
                            color: Colors.white70,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                FadeAnimation(
                                  delay: 1.7,
                                  child: Container(
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
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
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
                                          return 'Please enter Email Address';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                loading == true
                                    ? CircularProgressIndicator()
                                    : FadeAnimation(
                                        delay: 2.0,
                                        child: RoundedButton(
                                          bold: true,
                                          width: 160,
                                          heigth: 40,
                                          elevation: 20,
                                          text: 'RESET',
                                          radius: BorderRadius.circular(20),
                                          fontSize: 16,
                                          textColor: Colors.black,
                                          backgroundColor: Colors.yellowAccent,
                                          onPressed: () async {
                                            setState(() {
                                              loading = true;
                                            });
                                            await ForgotPassword()
                                                .passwordReset(
                                                    _emailController.text,
                                                    context)
                                                .then((value) {
                                              setState(() {
                                                loading = false;
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
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
        )
      ],
    );
  }
}
