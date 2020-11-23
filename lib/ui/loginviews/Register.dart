import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multi/ui/location/AddressAutoComplete.dart';
import 'package:service_exchange_multi/utils/Constants.dart';
import 'package:service_exchange_multi/utils/Dialoge.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginActivity.dart';

class Register extends StatefulWidget {
  String name, email, password, phoneNumber, jobTitle;
  List<String> address;

  Register(String name, String jobTitle, List<String> address, String email,
      String password, String phoneNumber) {
    this.address = new List<String>();
    this.name = name;
    this.jobTitle = jobTitle;
    this.address = address;
    this.email = email;
    this.password = password;
    this.phoneNumber = phoneNumber;
  }

  @override
  _RegisterStateState createState() => _RegisterStateState();
}

class _RegisterStateState extends State<Register> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final jobTitleController = TextEditingController();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  var mContext;
  FocusNode _focus = new FocusNode();
  static var openPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    FocusScope.of(context).unfocus();

    openPage = openPage + 1;

    if (openPage == 1) {
      Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) => AddressAutoComplete(
                nameController.text,
                jobTitleController.text,
                widget.address,
                emailController.text,
                passwordController.text,
                phoneController.text)),
      );
    }
    if (openPage > 1) {
      openPage = 0;
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    nameController.text = widget.name;
    emailController.text = widget.email;
    jobTitleController.text = widget.jobTitle;
    passwordController.text = widget.password;
    confirmPasswordController.text = widget.password;

    if (widget.address.length > 1) {
      String address = "";
      for (int i = 0; i < widget.address.length; i++) {
        address = address + " " + widget.address[i];
      }
      addressController.text = address;
    }

    /// Show alert dialog
    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = FlatButton(
        child: Text("Retry"),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ); // set up the button

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Error Occurred"),
        content: Text("An Error has Occurred, would you like to try again?  "),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    /// Handle user Registration
    Future<void> _handleSubmit(BuildContext context) async {
      try {
        Dialoge.showLoadingDialog(context, _keyLoader); //invoking login

        try {
          String emailToRegister =
              emailController.text.toString().replaceAll(" ", "");
          String passwordToRegister =
              passwordController.text.toString().replaceAll(" ", "");
          final newuser = await _auth.createUserWithEmailAndPassword(
              email: emailToRegister, password: passwordToRegister);

          if (newuser != null) {
            final User user = FirebaseAuth.instance.currentUser;
            final uid = user.uid;
            final DBRef = FirebaseDatabase.instance.reference().child('Users');

            final Map<String, String> usersHashMap = {
              'name': nameController.text,
              'jobTitle': jobTitleController.text,
              'phoneNumber': phoneController.text,
              'address': addressController.text,
              'posts': "none",
              'dpUrl': "default"
            };

            final prefs = await SharedPreferences.getInstance();

            await DBRef.child(uid).set(usersHashMap).then((result) {
              prefs.setString(
                  Constants.USER_NAME, nameController.text.toString());
              prefs.setString(
                Constants.USER_JOB,
                jobTitleController.text,
              );
              prefs.setString(Constants.USER_PHONE,
                  phoneController.text.replaceAll(" ", ""));
              prefs.setString(Constants.USER_ADDRESS, addressController.text);
              prefs.setString(Constants.USER_DP, "default");

              FirebaseAuth.instance.signOut();

              Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                  .pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginActivity()));
            });
          } else {
            Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                .pop(); //close the dialoge
            showAlertDialog(context);
          }
        } catch (e) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true)
              .pop(); //close the dialoge
          showAlertDialog(context);
        }
      } catch (error) {
        showAlertDialog(context);
      }
    }

    String validationText(
        String text, bool isEmail, bool isPassword, bool isConfirmPassword) {
      if (text.isEmpty) {
        return "* Cannot be left blank";
      }

      if (isConfirmPassword) {
        if (text != passwordController.text) {
          return "Confirmation Password not correct";
        }
      }

      if (isEmail && !text.contains("@") && !text.contains(".")) {
        return "wrong format, should be like example@abc.com";
      }

      if (isPassword) {
        String pattern =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regExp = new RegExp(pattern);
        if (!regExp.hasMatch(text)) {
          return "Password must contain \n * Atleast One Uppercase \n * Atleast One Number \n * Atleast One Special Character";
        }
      }

      return null;
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          body: Form(
              key: _formKey,
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                        Constants.DEFAULT_BLUE,
                        Constants.DEFAULT_ORANGE
                      ])),
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            return validationText(value, false, false, false);
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: jobTitleController,
                          validator: (value) {
                            return validationText(value, false, false, false);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Job Title',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: addressController,
                          focusNode: _focus,
                          validator: (value) {
                            return validationText(value, false, false, false);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Current Address',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            return validationText(value, true, false, false);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: phoneController,
                          validator: (value) {
                            return validationText(value, false, false, false);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            return validationText(value, false, true, false);
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            return validationText(value, false, false, true);
                          },
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Constants.DEFAULT_BLUE,
                            child: Text('Register'),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _handleSubmit(context);
                              }
                            },
                          )),
                      Container(
                          child: Row(
                        children: <Widget>[
                          Text('Already have an account?'),
                          FlatButton(
                              textColor: Colors.white,
                              child: Text(
                                'Login Instead',
                              ),
                              padding: EdgeInsets.all(30),
                              onPressed: () =>  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => LoginActivity())),

                              )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                    ],
                  )))),
    );
  }
}
