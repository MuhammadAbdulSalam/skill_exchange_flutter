import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_exchange_multi/ui/homepage/DemoPage.dart';
import 'package:service_exchange_multi/ui/homepage/LandingActivity.dart';
import 'package:service_exchange_multi/utils/Constants.dart';
import 'package:service_exchange_multi/utils/Dialoge.dart';

import 'Register.dart';

class LoginActivity extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginActivity> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  var firebaseAuth = FirebaseAuth.instance;

  @override
  void initState()  {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    try {
      if ( FirebaseAuth.instance.currentUser != null) {

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LandingActivity()),
            ModalRoute.withName("/Home"));
      }
    } catch (Exception) {}
  }

  /// Show alert dialog
  showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Retry"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    ); // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error Occurred"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// Handle user Registration
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialoge.showLoadingDialog(context, _keyLoader); //invoking login


      try {
        UserCredential userCredential =
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text
                .replaceAll(" ", ""),
            password: passwordController
                .text
                .replaceAll(" ", ""));

        if (userCredential.user.uid != null) {

          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LandingActivity()),
              ModalRoute.withName("/Home"));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showAlertDialog(context,
              "No user found with this email, please check your email and try again");
        } else if (e.code == 'wrong-password') {
          showAlertDialog(context,
              "Password is wrong, Please check and enter password again");
        }
      }

    } catch (Exception) {}
  }

  String validateText(String text, bool isEmail, bool isPassword) {
    if (text.isEmpty) {
      return "Cannot be left Blank";
    } else if (isEmail && !text.contains("@")) {
      return "Email wrong format, must be like example@abc.com";
    } else if (isPassword) {
      String pattern =
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regExp = new RegExp(pattern);
      if (!regExp.hasMatch(text)) {
        return "Password must contain \n * Atleast One Uppercase \n * Atleast One Number \n * Atleast One Special Character";
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<String> empty = new List<String>();
    empty.add("");

    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            child: new AlertDialog(
              title: new Text('Are you sure you want to exit?'),
              content: new Text(
                  'Press YES to close the app or press NO to continue using Service Exchange'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Form(
        key: _formKey,
        child: Scaffold(
            body: Center(
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                          Constants.DEFAULT_BLUE,
                          Constants.DEFAULT_ORANGE
                        ])),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(50),
                          child: new Image.asset('images/logo_main.png',
                              width: 150.00, height: 150.00),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) {
                              return validateText(value, true, false);
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            validator: (value) {
                              return validateText(value, false, true);
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            //forgot password screen
                          },
                          textColor: Colors.black45,
                          child: Text('Forgot Password ?'),
                        ),
                        Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Constants.DEFAULT_BLUE,
                              child: Text('Login'),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _handleSubmit(context);
                                }
                              },
                            )),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Text('Does not have account?'),
                            FlatButton(
                              textColor: Colors.white,
                              child: Text(
                                'Register Now',
                              ),
                              padding: EdgeInsets.all(30),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Register(
                                                "", "", empty, "", "", "")));
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ))
                      ],
                    )))),
      ),
    );
  }
}
