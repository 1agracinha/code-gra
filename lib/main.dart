
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/usuario_model.dart';
import 'homePage.dart';
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UsuarioModel>(model: UsuarioModel(), 
    child: MaterialApp(
      home: HomePage()
    ));
  }
}
