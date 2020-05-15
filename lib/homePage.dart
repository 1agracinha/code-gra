import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text("Ir para Login"),
            onPressed: () {
              Get.to(Login());
            },
          ),
        ),
      ),
    );
  }
}
