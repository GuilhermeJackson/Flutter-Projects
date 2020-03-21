import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/sigup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        // botao para criar conta ao lado do title
        actions: <Widget>[
          FlatButton(

            child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 15.0
                ),
            ),
            textColor: Colors.white,
            onPressed: (){
              // pushReplacement = quando clicado, a tela é substituida (ao criar conta, o usuario nao precisa fazer o login, ela ja vai estar logado)
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=>SingUpScreen())
              );
            },
          ),
        ],
      ),
      // Form = ele valida os campos de um formulário
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          // se o model esta carregando alguma coisa, CircularProgressIndicator é chamado
          if(model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                //TextFormField = Apenas um campo de texto
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "E-mail"
                  ),
                  keyboardType: TextInputType.emailAddress,
                  // validator = realiza uma verificação de e-mail
                  // ignore: missing_return
                  validator: (text) {
                    if(text.isEmpty || !text.contains("@")) return "E-mail inválido";
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Senha"
                  ),
                  obscureText: true,
                  // ignore: missing_return
                  validator: (text){
                    if(text.isEmpty || text.length <= 6) return "Senha inválida!";
                  },
                ),
                // mover algum widget para direita da tela
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){},
                    child: Text("Esqueci minha senha", textAlign: TextAlign.right),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text("Entrar",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      // pedi para validar os campos quando o botao é pressionando
                      if(_formKey.currentState.validate()){

                      }
                      model.signIn();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}