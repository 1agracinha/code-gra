import 'package:code_gra/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("Cadastro"),
        ),
        body: ScopedModelDescendant<UsuarioModel>(
            builder: (context, child, model) {
          if (model.estaLogando) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
                SizedBox(height: 20.0),
                Text("Estamos cadastrando os seus dados!",
                    style: TextStyle(color: Colors.pink))
              ],
            ));
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(color: Colors.pink)),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Insira seu nome";
                      }
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "email",
                        labelStyle: TextStyle(color: Colors.pink)),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Insira um e-mail";
                      } else {
                        if (!text.contains("@")) {
                          return "Insira um e-mail válido!";
                        }
                      }
                    },
                  ),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "senha",
                        labelStyle: TextStyle(color: Colors.pink)),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Insira uma senha";
                      } else {
                        if (text.length < 6) {
                          return "A senha precisa ter no mínimo 6 caracteres";
                        }
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> dadosUsuario = {
                            "nome": _nomeController.text,
                            "email": _emailController.text
                          };

                          model.cadastro(
                              dadosUsuario: dadosUsuario,
                              senha: _senhaController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      },
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
