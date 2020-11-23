import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multi/utils/Constants.dart';
import 'package:service_exchange_multi/utils/flipbar/src/flip_bar_item.dart';
import 'package:service_exchange_multi/utils/flipbar/src/flip_box_bar.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: MainActivity(),
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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Service Exchange"),
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
                      items: [
                        "images/logo_main.png",
                        "images/logo_main.png",
                        "images/logo_main.png",
                        "images/logo_main.png"
                      ].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration:
                                  BoxDecoration(color: Constants.DARK_GREY),
                              child: Image.asset(i),
                            );
                          },
                        );
                      }).toList(),
                    )),
                // Container(
                //   decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //           begin: Alignment.topLeft,
                //           end: Alignment.bottomRight,
                //           colors: <Color>[
                //         Constants.DEFAULT_ORANGE,
                //         Constants.DEFAULT_BLUE,
                //       ])),
                //   padding: EdgeInsets.all(10),
                //   child: Row(
                //     children: List.generate(
                //         colors.length,
                //         (index) => Expanded(
                //               child: GestureDetector(
                //                   onTap: () => print('Tapped:$index'),
                //                   child: Container(
                //                     height: 30,
                //                     color: Colors.transparent,
                //                     child: Container(
                //                       decoration: BoxDecoration(
                //                         shape: BoxShape.circle,
                //                         color: colors[index],
                //                       ),
                //                     ),
                //                   )),
                //             )),
                //   ),
                // ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: FlipBoxBar(
          selectedIndex: selectedIndex,
          items: [
            FlipBarItem(
                icon: Icon(Icons.map),
                text: Text("Home"),
                frontColor: Colors.blue,
                backColor: Colors.blueAccent),
            FlipBarItem(
                icon: Icon(Icons.perm_camera_mic_rounded),
                text: Text("Posts"),
                frontColor: Constants.DEFAULT_BLUE,
                backColor: Constants.BLUE_SHADE_2),
            FlipBarItem(
                icon: Icon(Icons.chrome_reader_mode),
                text: Text("Recieved"),
                frontColor: Colors.orange,
                backColor: Colors.orangeAccent),
            FlipBarItem(
                icon: Icon(Icons.print),
                text: Text("Profile"),
                frontColor: Colors.purple,
                backColor: Colors.purpleAccent),
            FlipBarItem(
                icon: Icon(Icons.add),
                text: Text("add"),
                frontColor: Colors.pink,
                backColor: Colors.pinkAccent),
          ],
          onIndexChanged: (newIndex) {
            setState() {
              selectedIndex = newIndex;
            }
          },
        ),

        // floatingActionButton: FloatingActionButton(
        //     tooltip: 'Add', // used by assistive technologies
        //     child: Icon(Icons.add),
        //     onPressed: () async {
        //       FirebaseAuth.instance.signOut();
        //     }),
      ),
    );
  }
}
