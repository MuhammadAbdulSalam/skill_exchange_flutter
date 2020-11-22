import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_exchange_multi/utils/Constants.dart';

import 'Register.dart';

class LoginActivity extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginActivity> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    List<String> empty = new List<String>();
    empty.add("");


    Future<bool> _onWillPop() {
      return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Are you sure you want to exit?'),
          content: new Text('Press YES to close the app or press NO to continue using Service Exchange'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text('Yes'),
            ),
          ],
        ),
      ) ?? false;
    }


    return WillPopScope(
      onWillPop: () => _onWillPop(),
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
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(50),
                        child: new Image.asset('images/logo_main.png',
                            width: 150.00, height: 150.00),
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      FlatButton(
                        onPressed: () {
                          //forgot password screen
                        },
                        textColor: Colors.black45,
                        child: Text('Forgot Password ?'),
                      ),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Constants.DEFAULT_BLUE,
                            child: Text('Login'),
                            onPressed: () {
                              //TODO
                            },
                          )),
                      Container(
                          child: Row(
                        children: <Widget>[
                          Text('Does not have account?'),
                          FlatButton(
                            textColor: Colors.white,
                            child: Text(
                              'Register Now',
                            ),
                            padding: EdgeInsets.all(30),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Register("", "", empty, "", "", "")));
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))
                    ],
                  )))),
    );
  }
}
