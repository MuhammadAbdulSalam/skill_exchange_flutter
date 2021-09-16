import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multi/utils/Constants.dart';
import 'package:service_exchange_multi/utils/flipbar/src/flip_bar_item.dart';
import 'package:service_exchange_multi/utils/flipbar/src/flip_box_bar.dart';


void main() async {

  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/landingpage',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/landingpage': (context) => MainActivity(),
      // When navigating to the "/second" route, build the SecondScreen widget.
    },
  ));
}



final colors = [
  Colors.red,
  Colors.blue,
  Colors.brown,
  Colors.cyan,
  Colors.green
];

class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

    );
  }

}
