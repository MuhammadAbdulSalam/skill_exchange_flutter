import 'package:flutter/material.dart';
import 'package:service_exchange_multi/utils/Constants.dart';

final icons = [
  Icons.person,
  Icons.near_me,
  Icons.refresh,
  Icons.filter_alt_rounded,
];

class PostsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
               child: new Column(
                 children: [
                   new Container(
                     height: MediaQuery.of(context).size.height - 130,
                     child: new ListView.builder(
                       itemCount: 60,
                       itemBuilder: (BuildContext context, int index) {
                         return new Text('Item $index');
                       },
                     ),
                   )
                 ],
               )
              ),
            ])
        )
    );
  }
}