import 'package:flutter/material.dart';
import 'package:service_exchange_multi/utils/Constants.dart';

class PostNewAdd extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final icons = [
    Icons.clear,
    Icons.my_location,
    Icons.auto_fix_high,
  ];


  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Constants.THEME_DEFAULT_BACKGROUND,
        child:  SafeArea(
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
                          onTap: () => {
                            if(index == 0)
                              {
                                emailController.text = ""
                              }
                          },
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
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Text(
                          "Please enter following details about service you need:",
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: emailController,
                          style: TextStyle(
                              color: Constants.THEME_DEFAULT_TEXT),
                          decoration: InputDecoration(
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
                          style: TextStyle(
                              color: Constants.THEME_DEFAULT_TEXT),
                          decoration: InputDecoration(
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
                        height: 100.0,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.white, width: 1.0)),
                        child: TextFormField(
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
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: Text(
                          "Please enter following details about service you will provide in return:",
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(
                              color: Constants.THEME_DEFAULT_TEXT),
                          decoration: InputDecoration(
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
                        height: 100.0,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.white, width: 1.0)),
                        child: TextFormField(
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
                    ],
                  ),
                ),
              ),
            ])
        )
    );
  }
}
