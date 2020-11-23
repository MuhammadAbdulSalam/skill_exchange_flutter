import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multi/utils/Constants.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: MainActivity(),
  ));
}

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
          child: Text('Hello, world!'),
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
