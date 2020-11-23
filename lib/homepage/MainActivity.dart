import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multi/utils/Constants.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: MainActivity(),
  ));
}

final colors = [Colors.red, Colors.blue, Colors.brown, Colors.cyan,  Colors.green];

class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Register"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Constants.DEFAULT_ORANGE,
                  Constants.DEFAULT_BLUE,
                ])),
          ),
        ),
        // body is the majority of the screen.
        body: Center(
          child: Container(
            color: Colors.black87,
            child: ListView(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800)),
                      items: ["images/logo_main.png", "images/logo_main.png", "images/logo_main.png", "images/logo_main.png"].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(color: Constants.DARK_GREY),
                                child: Image.asset(i),
                                );
                          },
                        );
                      }).toList(),
                    )),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Constants.DEFAULT_ORANGE,
                            Constants.DEFAULT_BLUE,
                          ])),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: List.generate(
                        colors.length,
                            (index) => Expanded(
                          child: GestureDetector(
                              onTap: () => print('Tapped:$index'),
                              child: Container(
                                height: 30,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors[index],
                                  ),
                                ),
                              )),
                        )),
                  ),

                ),
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
            tooltip: 'Add', // used by assistive technologies
            child: Icon(Icons.add),
            onPressed: () async {
              FirebaseAuth.instance.signOut();
            }),
      ),
    );
  }
}
