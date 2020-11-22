import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multi/location/AddressAutoComplete.dart';
import 'package:service_exchange_multi/loginviews/LoginActivity.dart';
import 'package:service_exchange_multi/utils/Constants.dart';
import 'package:service_exchange_multi/utils/Dialoge.dart';

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

    final GlobalKey<State> _keyLoader = new GlobalKey<State>();


    Future<void> _handleSubmit(BuildContext context) async {
      try {
        Dialoge.showLoadingDialog(context, _keyLoader);//invoking login
        try {
          String emailToRegister =
          emailController.text.toString();
          String passwordToRegister =
          passwordController.text.toString();
          final newuser =
          await _auth.createUserWithEmailAndPassword(
              email: emailToRegister,
              password: passwordToRegister);

          if (newuser != null) {
            Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
            print("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginActivity()));
            // setState(() {
            //   showProgress = false;
            // });
          }
        } catch (e) {}

      } catch (error) {
        print(error);
      }
    }



    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          body: Center(
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
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
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
                        child: TextField(
                          controller: jobTitleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Job Title',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: addressController,
                          focusNode: _focus,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Current Address',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          obscureText: true,
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
                        child: TextField(
                          obscureText: true,
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
                              // setState(() {
                              //   showProgress = true;
                              // });
                              _handleSubmit(context);

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
                              onPressed: () => Navigator.pop(context))
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                    ],
                  )))),
    );
  }
}
