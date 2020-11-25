import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:service_exchange_multi/ui/loginviews/LoginActivity.dart';
import 'package:service_exchange_multi/utils/Constants.dart';
import 'package:service_exchange_multi/utils/Dialoge.dart';
import 'package:service_exchange_multi/utils/FirebaseHelper.dart';
import 'package:service_exchange_multi/utils/flipbar/src/TemplateDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PostNewAdd extends StatefulWidget {
  @override
  _PostNewAddState createState() => _PostNewAddState();
}

class _PostNewAddState extends State<PostNewAdd> {
  BuildContext mainContext;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Position _currentPosition;
  String currentLocation;

  final currentLocationController = TextEditingController();
  final requestedServiceController = TextEditingController();
  final requestedDescriptionController = TextEditingController();
  final returnServiceController = TextEditingController();
  final returnDescriptionController = TextEditingController();

  final icons = [
    Icons.clear,
    Icons.my_location,
    Icons.auto_fix_high,
  ];

  static const TOOLBAR_CLEAR_INDEX = 0;
  static const TOOLBAR_LOCATION_INDEX = 1;
  static const TOOLBAR_MAGIC_INDEX = 2;

  void _getCurrentLocation(BuildContext context) async {
    currentLocationController.text = "Checking location...";

    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      _currentPosition = position;

      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      await Geocoder.local
          .findAddressesFromCoordinates(coordinates)
          .then((value) {
        var first = value.first;

        currentLocationController.text = "${first.addressLine}";
      }).catchError((onError) {
        currentLocationController.text = "Unknown Location";
      });
    }).catchError((e) {
      print(e);
      currentLocationController.text = "Unknown Location Err";
    });
  }

  void clearTextBoxes() {
    currentLocationController.text = "";
    requestedServiceController.text = "";
    requestedDescriptionController.text = "";
    returnServiceController.text = "";
    returnDescriptionController.text = "";
  }

  Future<void> _topBarFunctions(BuildContext context, int index) async {
    if (index == TOOLBAR_CLEAR_INDEX) {
      clearTextBoxes();
    }
    if (index == TOOLBAR_LOCATION_INDEX) {
      _getCurrentLocation(context);
    }

    if (index == TOOLBAR_MAGIC_INDEX) {
      final prefs = await SharedPreferences.getInstance();
      String templateService =
          await prefs.getString(Constants.TEMPLATE_SERVICE) ?? "";
      String templateDescription =
          await prefs.getString(Constants.TEMPLATE_DESCRIPTION) ?? "";

      if (templateDescription == "default" && templateService == "default") {
        showAlertDialog(context,
            "You do not have a template stored. Would you like to save a template now? You can then use this tepmlate by pressing the magic wand icon");
      } else {
        returnServiceController.text = templateService;
        returnDescriptionController.text = templateDescription;
      }
    }
  }

  /// Show alert dialog
  showErrorDialog(BuildContext context) {
    // set up the button
    Widget yesButton = FlatButton(
      child: Text("yes"),
      onPressed: () {},
    );

    Widget noButton = FlatButton(
      child: Text("no"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    ); // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error Occurred"),
      content: Text(
          "An error occurred while updating your request, would you like to try again?"),
      actions: [yesButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// Show alert dialog
  showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget yesButton = FlatButton(
      child: Text("yes"),
      onPressed: () {
        Navigator.of(context).pop(true);
        showDialog(
          context: context,
          builder: (_) => TemplateDialog(),
        );
      },
    );

    Widget noButton = FlatButton(
      child: Text("no"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    ); // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No template stored"),
      content: Text(text),
      actions: [yesButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String validateForm(String value) {
    if (value.isEmpty) {
      return "* cannot be left blank";
    }
    return null;
  }

  Future<void> _handlePostAdds(BuildContext context) async {
    Dialoge.showLoadingDialog(context, _keyLoader); //invoking progreebar

    final Map<String, String> postHashMap = {
      'postTitle': requestedServiceController.text,
      'description': requestedServiceController.text,
      'returnService': requestedDescriptionController.text,
      'returnDescription': returnServiceController.text,
      'latitude': _currentPosition.latitude.toString(),
      'longitude': _currentPosition.longitude.toString(),
      'offerStatus': "new",
      'dealMade': 'pending',
      'dpUrl': "default"
    };

    String postKey = Uuid().v4();

    await FirebaseHelper.POST_DB
        .child(postKey)
        .set(postHashMap)
        .then((value) async {
      await FirebaseHelper.USER_DB
          .child("posts")
          .child(postKey)
          .set(postKey)
          .then((value) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

        clearTextBoxes();
      }).catchError((onError) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        showErrorDialog(context);
      });
    }).catchError((onError) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showErrorDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocationController.text.isEmpty) {
      _getCurrentLocation(context);
    }

    return Container(
        color: Constants.THEME_DEFAULT_BACKGROUND,
        child: SafeArea(
            child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 2.0, color: Constants.THEME_DEFAULT_BORDER),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: List.generate(
                icons.length,
                (index) => Expanded(
                  child: GestureDetector(
                      onTap: () => {_topBarFunctions(context, index)},
                      child: Container(
                        height: 30,
                        child: Icon(
                          icons[index],
                          color: Colors.blue,
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Text(
                        "Please enter following details about service you need:",
                        style: TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: currentLocationController,
                        style: TextStyle(color: Constants.THEME_DEFAULT_TEXT),
                        validator: (value) {
                          return validateForm(value);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Constants.THEME_TEXT_BOX_COLOR,
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
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: requestedServiceController,
                        validator: (value) {
                          return validateForm(value);
                        },
                        style: TextStyle(color: Constants.THEME_DEFAULT_TEXT),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Constants.THEME_TEXT_BOX_COLOR,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Constants.THEME_DEFAULT_BORDER,
                                width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Required Service',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      height: 5 * 24.0,
                      child: TextFormField(
                        validator: (value) {
                          return validateForm(value);
                        },
                        controller: requestedDescriptionController,
                        maxLength: null,
                        maxLines: 5,
                        style: TextStyle(color: Constants.THEME_DEFAULT_TEXT),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Constants.THEME_TEXT_BOX_COLOR,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Constants.THEME_DEFAULT_BORDER,
                                width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: Text(
                        "Please enter following details about service you will provide in return:",
                        style: TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: returnServiceController,
                        validator: (value) {
                          return validateForm(value);
                        },
                        style: TextStyle(color: Constants.THEME_DEFAULT_TEXT),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Constants.THEME_TEXT_BOX_COLOR,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Constants.THEME_DEFAULT_BORDER,
                                width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Return Service',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      height: 5 * 24.0,
                      child: TextFormField(
                        validator: (value) {
                          return validateForm(value);
                        },
                        controller: returnDescriptionController,
                        maxLength: null,
                        maxLines: 5,
                        style: TextStyle(color: Constants.THEME_DEFAULT_TEXT),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Constants.THEME_TEXT_BOX_COLOR,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Constants.THEME_DEFAULT_BORDER,
                                width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blueAccent,
                          child: Text('Post Now'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _handlePostAdds(context);
                            }
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        ])));
  }
}
