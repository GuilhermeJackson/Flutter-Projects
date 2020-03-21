import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

// Model = objeto q guarda o estado de alguma coisa (no caso o login)
class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  //Carrega as informações do usuário
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  // deslogar
  // @required = usando para auto completar automatico quando a função for chamada (quando usado, o mesmo é obrigatório)
  void signUp({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSucess, @required VoidCallback  onFail}) {
    // notificando o usuario que esta sendo carregado
    isLoading = true;
    notifyListeners();

    //tentativa de criar o usuario
    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((user) async{
          firebaseUser = user as FirebaseUser;

          await _saveUserData(userData);

          onSucess();
          isLoading = false;
          notifyListeners();
    }).catchError((e){
        onFail();
        isLoading = false;
        notifyListeners();
    });
  }

  //fazer o login
  void signIn() async{
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    isLoading = false;

    notifyListeners();
  }

  //recuperar senha
  void recoverPass(){

  }

  //verifica se o usuario está logado
  bool isLoggedIn (){

  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
}