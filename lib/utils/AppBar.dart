

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'Constants.dart';

class CustomAppBar extends AppBarPlacesAutoCompleteTextField {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ])
          ),
        ),
      ),
    );
  }
}