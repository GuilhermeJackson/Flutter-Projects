import 'package:scoped_model/scoped_model.dart';

// Model = objeto q guarda o estado de alguma coisa (no caso o login)
class UserModel extends Model {
  //Usuario

  bool isLoading = false;

  // deslogar
  void signUp(){
    isLoading = true;
    notifyListeners();


  }

  //fazer o login
  void signIn(){

  }

  //recuperar senha
  void recoverPass(){

  }

  //verifica se o usuario está logado
  bool isLoggedIn (){

  }
}