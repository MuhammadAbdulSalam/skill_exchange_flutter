import 'package:flutter/material.dart';
import 'package:service_exchange_multi/ui/loginviews/Register.dart';
import 'package:service_exchange_multi/utils/Constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'AddressSearch.dart';
import 'PlaceService.dart';

class AddressAutoComplete extends StatefulWidget {
  String name, email, password, phoneNumber, jobTitle;
  List<String> addressArray;

  AddressAutoComplete(String name, String jobTitle, List<String> address,
      String email, String password, String phoneNumber) {
    this.name = name;
    this.jobTitle = jobTitle;
    this.addressArray = address;
    this.email = email;
    this.password = password;
    this.phoneNumber = phoneNumber;
  }

  @override
  _AddressAutoCompleteState createState() => _AddressAutoCompleteState();
}

class _AddressAutoCompleteState extends State<AddressAutoComplete> {
  String completeAddress;
  final _controller = TextEditingController();
  final _streetController = TextEditingController();
  final _streetNumberController = TextEditingController();
  final _cityController = TextEditingController();
  final _postcodeController = TextEditingController();
  int reset = 0;


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    if(widget.addressArray.length > 2)
      {
        _streetNumberController.text = widget.addressArray[0];
        _streetController.text = widget.addressArray[1];
        _cityController.text = widget.addressArray[2];
        _postcodeController.text = widget.addressArray[3];
      }
    super.initState();
  }

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
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
                readOnly: true,
                onTap: () async {
                  // generate a new token here
                  final sessionToken = Uuid().v4();
                  final Suggestion result = await showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken),
                  );
                  // This will change the text displayed in the TextField
                  if (result != null) {
                    final placeDetails = await PlaceApiProvider(sessionToken)
                        .getPlaceDetailFromId(result.placeId);
                    setState(() {
                      _streetNumberController.text = "";
                      _streetController.text = "";
                      _cityController.text = "";
                      _postcodeController.text = "";


                      _controller.text = result.description;
                      _streetNumberController.text = placeDetails.streetNumber;
                      _streetController.text = placeDetails.street;
                      if (placeDetails.postalTown == null) {
                        if (placeDetails.city == null) {
                          _cityController.text = "";
                        }
                        _cityController.text = placeDetails.city;
                      } else {
                        _cityController.text = placeDetails.postalTown;
                      }
                      _postcodeController.text = placeDetails.zipCode;
                    });
                  }
                },
              style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  icon: Container(
                    width: 10,
                    height: 10,
                    child: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Tap Here to search for address",
                  border: InputBorder.none,

                  contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _streetNumberController,
                  // controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "First Line of Address",
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _streetController,
                  // controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Second Line of Address",
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _cityController,
                  // controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "City",
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _postcodeController,
                  // controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Post Code",
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Constants.DEFAULT_BLUE,
                    child: Text('Done'),
                    onPressed: () {
                      List<String> newAddress = new List<String>();

                      newAddress.add(_streetNumberController.text);
                      newAddress.add(_streetController.text);
                      newAddress.add(_cityController.text);
                      newAddress.add(_postcodeController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Register(
                                widget.name,
                                widget.jobTitle,
                                newAddress,
                                widget.email,
                                widget.password,
                                widget.phoneNumber)),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
