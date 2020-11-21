import 'dart:async';

import 'package:flutter/material.dart';
import 'package:service_exchange_multi/utils/Constants.dart';

import 'loginviews/LoginActivity.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new LoginActivity()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Constants.DEFAULT_BLUE, Constants.DEFAULT_ORANGE
                ],
              )),
          child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                "images/logo_main.png",
                width: 200,
                height: 200,
              )),
        ),
      ),
    );
  }
}
