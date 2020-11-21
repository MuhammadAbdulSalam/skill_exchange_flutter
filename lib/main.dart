import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_exchange_multi/utils/Constants.dart';

import 'loginviews/LoginActivity.dart';
import 'package:flutter/animation.dart';



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


class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{


  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }


  //Animation
  Animation<double> backgroundAnimation;

  AnimationController _backgroundController;

  // list of bubble widgets shown on screen
  final bubbleWidgets = List<Widget>();

  // flag to check if the bubbles are already present or not.
  bool areBubblesAdded = false;

  Animatable<Color> backgroundDark = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Colors.blue[800],
        end: Colors.pink[800],
      ),
    ),
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Colors.pink[800],
        end: Colors.blue[800],
      ),
    ),
  ]);
  Animatable<Color> backgroundNormal = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Colors.blue[500],
        end: Colors.pink[500],
      ),
    ),
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Colors.pink[500],
        end: Colors.blue[500],
      ),
    ),
  ]);
  Animatable<Color> backgroundLight = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Colors.blue[200],
        end: Colors.pink[200],
      ),
    ),
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Colors.pink[200],
        end: Colors.blue[200],
      ),
    ),
  ]);

  AlignmentTween alignmentTop = AlignmentTween(begin: Alignment.topRight,end: Alignment.topLeft);
  AlignmentTween alignmentBottom = AlignmentTween(begin: Alignment.bottomRight,end: Alignment.bottomLeft);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    backgroundAnimation = CurvedAnimation(parent: _backgroundController, curve: Curves.easeIn)
      ..addStatusListener((status){
        if(status == AnimationStatus.completed){
          setState(() {

            _backgroundController.forward(from: 0);
          });
        }
        if(status == AnimationStatus.dismissed){
          setState(() {
            _backgroundController.forward(from: 0);
          });
        }
      });

    startTime();

  }
  @override
  Widget build(BuildContext context) {

    // Add below to add bubbles intially.

    return AnimatedBuilder(
      animation: backgroundAnimation,
      builder: (context, child){
        return Scaffold(

          body:  Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: alignmentTop.evaluate(backgroundAnimation),
                    end: alignmentBottom.evaluate(backgroundAnimation),
                    colors: [
                      backgroundDark.evaluate(backgroundAnimation),
                      backgroundNormal.evaluate(backgroundAnimation),
                      backgroundLight.evaluate(backgroundAnimation),

                    ],
                  ),
                ),
              ),


            ]
                +[Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: new Image.asset("images/logo_main.png", width: 170, height: 170)
                    ),
                  ],
                ),],
          ),


        );
      },
    );
  }
  @override
  void dispose() {
    super.dispose();
    _backgroundController.dispose();
  }

}

