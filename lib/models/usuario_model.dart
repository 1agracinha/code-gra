import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUsuario;
  Map<String, dynamic> dadosUsuario = Map();

  bool estaLogando = false;

  void entrar({@required String email, @required String senha, @required VoidCallback onSuccess, @required VoidCallback onFail}) async{
    estaLogando = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: senha).then(
      (usuario){
          firebaseUsuario = usuario;
          onSuccess();
          estaLogando = false;
          notifyListeners();

    }).catchError((e){
      onFail();
      estaLogando = false;
      notifyListeners();
    });
  }

  void cadastro({@required Map<String, dynamic> dadosUsuario, @required String senha, @required VoidCallback onSuccess, @required VoidCallback onFail}){
    estaLogando = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: dadosUsuario['email'], 
      password: senha).then((usuario) async{
        firebaseUsuario = usuario;

        await _salvarDadosUsuario(dadosUsuario);
        onSuccess();
        estaLogando = false;
        notifyListeners();


      }).catchError((e){
        onFail();
        estaLogando = false;
        notifyListeners();
      });

  }

  void recuperarSenha(){

  }

  void sair() async {
    await _auth.signOut();
    dadosUsuario = Map();
    firebaseUsuario = null;
    notifyListeners();
  }

  bool estaLogado(){
    return firebaseUsuario != null;

  }

  Future<Null> _salvarDadosUsuario(Map<String, dynamic> dadosUsuario) async{
    this.dadosUsuario = dadosUsuario;
    await Firestore.instance.collection("usuarios").document(firebaseUsuario.uid).setData(dadosUsuario);
  }
}