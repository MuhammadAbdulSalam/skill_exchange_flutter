




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multi/loginviews/LoginActivity.dart';
import 'package:service_exchange_multi/utils/Constants.dart';


class Register extends StatelessWidget {

  final _auth =   FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
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
                        // controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Address',
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
                                  email: "s@s.com", password: "00000000");
                              if (newuser != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginActivity()),
                                );
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
                              onPressed: () => Navigator.pop(context)

                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ))

                  ],
                ))));
  }
}
