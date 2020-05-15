import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Feed")),
        body: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Deslogar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
