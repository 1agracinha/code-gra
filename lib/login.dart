import 'dart:ui';

import 'package:code_gra/feed.dart';
import 'package:code_gra/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import 'cadastro.dart';
import 'homePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var formKey = _formKey;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
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
                Text("Estamos validando os seus dados!",
                    style: TextStyle(color: Colors.pink))
              ],
            ));
          }
          return Stack(
            children: <Widget>[
              // BACKGROUND
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/fundo2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),

// CABEÇALHO
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/logo.png',
                            width: 60,
                          ),

// CAMPOS DE ENTRADA

                          Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                // EMAIL
                                new Theme(
                                  data: new ThemeData(
                                    primaryColor: Colors.white,
                                    accentColor: Colors.white,
                                    cursorColor: Colors.white,
                                  ),
                                  child: Container(
                                    width: 260,
                                    padding:
                                        EdgeInsetsDirectional.only(bottom: 20),
                                    child: new TextFormField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: new InputDecoration(
                                          icon: Icon(Icons.mail),
                                          labelText: "Email",
                                          labelStyle: new TextStyle(
                                              color: const Color(0xFFFFFFFF)),
                                        ),
                                        validator: (text) {
                                          if (text.isEmpty) {
                                            return "Insira um e-mail";
                                          } else {
                                            if (!text.contains("@")) {
                                              return "Insira um e-mail válido";
                                            }
                                          }
                                        }),
                                  ),
                                ),

                                // SENHA
                                new Theme(
                                  data: new ThemeData(
                                    primaryColor: Colors.white,
                                    accentColor: Colors.white,
                                    cursorColor: Colors.white,
                                  ),
                                  child: Container(
                                    width: 260,
                                    padding:
                                        EdgeInsetsDirectional.only(bottom: 20),
                                    child: new TextFormField(
                                      controller: _senhaController,
                                      obscureText: true,
                                      decoration: new InputDecoration(
                                        icon: Icon(Icons.vpn_key),
                                        labelText: "Senha",
                                        labelStyle: new TextStyle(
                                            color: const Color(0xFFFFFFFF)),
                                      ),
                                      validator: (text) {
                                        if (text.isEmpty) {
                                          return "Insira uma senha";
                                        } else {
                                          if (text.length < 6) {
                                            return "A senha tem menos que 6 caracteres";
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),

                                // BUTTONS;

// ENTRAR BUTTON
                                RaisedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {}
                                    model.entrar(
                                        email: _emailController.text,
                                        senha: _senhaController.text,
                                        onSuccess: _onSuccess,
                                        onFail: _onFail);
                                  },
                                  child: Text("Entrar",
                                      style: TextStyle(color: Colors.white)),
                                  color: Colors.pinkAccent,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      65, 10, 65, 10),
                                ),
                              ],
                            ),
                          ),

                          FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Esqueceu a senha?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

// SEPARACAO
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: (Row(
                              children: <Widget>[
                                Expanded(
                                    child: Divider(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  indent: 40,
                                  endIndent: 7,
                                )),
                                Text(
                                  "OU",
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.5)),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    indent: 7,
                                    endIndent: 40,
                                  ),
                                ),
                              ],
                            )),
                          ),

                          OutlineButton(
                            onPressed: () {
                              Get.to(Cadastro());
                            },
                            child: Text(
                              "Registrar",
                              style: TextStyle(color: Colors.white),
                            ),
                            padding:
                                EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                            highlightedBorderColor: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  void _onSuccess() {
     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Feed()),
  );
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
