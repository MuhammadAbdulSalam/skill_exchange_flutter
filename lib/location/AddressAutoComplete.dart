import 'package:flutter/material.dart';
import 'package:service_exchange_multi/utils/Constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'AddressSearch.dart';
import 'PlaceService.dart';

class AddressAutoComplete extends StatefulWidget {
  @override
  _AddressAutoCompleteState createState() => _AddressAutoCompleteState();
}

class _AddressAutoCompleteState extends State<AddressAutoComplete> {
  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      body: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    _controller.text = result.description;
                    _streetNumber = placeDetails.streetNumber;
                    _street = placeDetails.street;
                    _city = placeDetails.city;
                    _zipCode = placeDetails.zipCode;
                  });
                }
              },
              decoration: InputDecoration(
                icon: Container(
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                hintText: "Enter your shipping address",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Street Number: $_streetNumber'),
            Text('Street: $_street'),
            Text('City: $_city'),
            Text('ZIP Code: $_zipCode'),
          ],
        ),
      ),
    );
  }
}
