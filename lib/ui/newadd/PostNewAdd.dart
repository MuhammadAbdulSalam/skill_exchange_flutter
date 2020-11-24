import 'package:flutter/material.dart';
import 'package:service_exchange_multi/utils/Constants.dart';

class PostNewAdd extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Container(
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 5.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Current Location',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )

                ),


              ),
      ),
    );
  }
}
