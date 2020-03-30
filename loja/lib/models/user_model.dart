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

  //Carrega usuário que já esatava logado quando o app é aberto novamente
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

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

      firebaseUser = user;


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
  void signIn({@required String email, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then(
            (user) async {
              firebaseUser = user;

              await _loadCurrentUser();

              onSuccess();
              isLoading = false;
              notifyListeners();
    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async{
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }


  //recuperar senha
  void recoverPass(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

  // Indica se o usuario está logado
  bool isLoggedIn(){
    return firebaseUser != null;
  }

  // Registra as informações da conta do usuario no banco de dados
  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  // função para pegar as informações do usuario q está logado
  Future<Null> _loadCurrentUser() async{
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance.collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

}