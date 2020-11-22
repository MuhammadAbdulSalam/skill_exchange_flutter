import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multi/location/AddressAutoComplete.dart';
import 'package:service_exchange_multi/utils/Constants.dart';

class Register extends StatefulWidget {
  @override
  __RegisterStateState createState() => __RegisterStateState();
}

class __RegisterStateState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  FocusNode _focus = new FocusNode();
  var mContext;
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

    if(openPage == 1){
      Navigator.push(
        mContext,
        MaterialPageRoute(builder: (context) => AddressAutoComplete()),
      );
    }
    if(openPage > 1)
      {
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

    return Scaffold(
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
                        // controller: nameController,
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
                        // controller: nameController,
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
                        // controller: nameController,
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
                        obscureText: true,
                        // controller: passwordController,
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
                        // controller: passwordController,
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
                        // controller: passwordController,
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
                            try {
                              final newuser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: "abc@abc.com",
                                      password: "00000000");
                              if (newuser != null) {
                                Navigator.pop(context);
                                // setState(() {
                                //   showProgress = false;
                                // });
                              }
                            } catch (e) {}
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
                ))));
  }
}
