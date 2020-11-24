import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_exchange_multi/ui/newadd/PostNewAdd.dart';
import 'package:service_exchange_multi/utils/Constants.dart';
import 'package:service_exchange_multi/utils/CustomPagerPhysics.dart';
import 'package:service_exchange_multi/utils/flipbar/src/flip_bar_item.dart';
import 'package:service_exchange_multi/utils/flipbar/src/flip_box_bar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: LandingActivity(),
    );
  }
}


final icons = [
  Icons.clear_all,
  Icons.location_pin,
  Icons.auto_fix_high,

];


class LandingActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingActivity();
  }
}

class _LandingActivity extends State<LandingActivity> {
  int selectedIndex = 0;
  PageController _pageController;

  void _changePage(int pageNum) {
    setState(() {
      selectedIndex = pageNum;
      _pageController.animateToPage(
        pageNum,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 100.0,
                  floating: true,
                  pinned: false,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Constants.DEFAULT_ORANGE,
                          Constants.DEFAULT_BLUE,
                        ])),
                    child: Container(
                        child: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image.network(
                        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                        fit: BoxFit.cover,
                      ),
                    )),
                  ),
                ),
              ];
            },
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) {
                setState(() {
                  selectedIndex = page;
                });
              },
              controller: _pageController,
              children: [
                PlaceholderWidget(Colors.black87),
                PlaceholderWidget(Constants.BLUE_SHADE_2),
                PlaceholderWidget(Colors.orangeAccent),
                Container(
                  color: Colors.black87,
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 2.0,
                                color: Constants.THEME_DEFAULT_BORDER),
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: List.generate(
                              icons.length,
                              (index) => Expanded(
                                    child: GestureDetector(
                                        onTap: () => print('Tapped:$index'),
                                        child: Container(
                                          height: 30,
                                          color: Colors.transparent,
                                          child: Icon(
                                            icons[index],
                                            color: Colors.white60,
                                          ),
                                        )),
                                  )),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.THEME_DEFAULT_BORDER,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Current Location',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        bottomNavigationBar: FlipBoxBar(
          selectedIndex: selectedIndex,
          items: [
            FlipBarItem(
                icon: Icon(Icons.home),
                text: Text("Home"),
                frontColor: Colors.blueAccent,
                backColor: Colors.blue),
            FlipBarItem(
                icon: Icon(Icons.bookmark),
                text: Text("Posts"),
                frontColor: Colors.orange,
                backColor: Colors.orangeAccent),
            FlipBarItem(
                icon: Icon(Icons.list),
                text: Text("Offers"),
                frontColor: Colors.purple,
                backColor: Colors.purpleAccent),
            FlipBarItem(
                icon: Icon(Icons.post_add),
                text: Text("Add"),
                frontColor: Colors.pink,
                backColor: Colors.pinkAccent),
          ],
          onIndexChanged: (newIndex) {
            onTabTapped(newIndex);
          },
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
      _changePage(index);
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
