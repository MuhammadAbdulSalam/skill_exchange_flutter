import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';

class TemplateDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TemplateDialog();
}

class _TemplateDialog extends State<TemplateDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  final templateService = TextEditingController();
  final templateDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }


  String validateForm(String text){
    if(text.isEmpty)
      {
        return "Cannot be left blank";
      }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              height: 330.0,
              decoration: ShapeDecoration(
                  color: Color.fromRGBO(41, 167, 77, 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Text(
                              "Please enter following details, all fields are necessary and cannot be left blank",
                              style: TextStyle(
                                  color: Constants.THEME_DEFAULT_TEXT, fontWeight: FontWeight.bold),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: templateService,
                              validator: (value) {
                                return validateForm(value);
                              },
                              style: TextStyle(
                                  color: Constants.THEME_DEFAULT_TEXT),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.THEME_DEFAULT_BORDER,
                                      width: 1.0),
                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Service you provide',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 100.0,
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.white, width: 1.0)),
                            child: TextFormField(
                              validator: (value) {
                                return validateForm(value);
                              },
                              controller: templateDescription,
                              maxLength: null,
                              maxLines: null,
                              style: TextStyle(
                                  color: Constants.THEME_DEFAULT_TEXT),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: '  Description',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),

                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ButtonTheme(
                                        minWidth: 110.0,
                                        child: RaisedButton(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0)),
                                          splashColor: Colors.white.withAlpha(40),
                                          child: Text(
                                            'Save',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.0),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState.validate()) {

                                              final prefs = await SharedPreferences.getInstance();

                                              await prefs.setString(Constants.TEMPLATE_SERVICE, templateService.text);
                                              await prefs.setString(Constants.TEMPLATE_DESCRIPTION, templateDescription.text).then((value) {
                                                Navigator.of(context).pop(true);

                                              });
                                            }
                                          },
                                        )),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                                      child: ButtonTheme(
                                          height: 35.0,
                                          minWidth: 110.0,
                                          child: RaisedButton(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.0)),
                                            splashColor: Colors.white.withAlpha(40),
                                            child: Text(
                                              'Cancel',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                Navigator.of(context).pop(true);
                                              });
                                            },
                                          ))),
                                ],
                              ))

                        ],
                      ),
                    ),
                  ),

                ],
              )),
        ),
      ),
    );
  }
}
