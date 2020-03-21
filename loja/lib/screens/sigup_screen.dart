import 'package:flutter/material.dart';

class SingUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            //TextFormField = Apenas um campo de texto
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Nome completo"
              ),
              keyboardType: TextInputType.emailAddress,
              // validator = realiza uma verificação de e-mail
              // ignore: missing_return
              validator: (text) {
                if(text.trim().isEmpty) return "Nome inválido";
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "E-mail"
              ),
              keyboardType: TextInputType.emailAddress,
              // validator = realiza uma verificação de e-mail
              // ignore: missing_return
              validator: (text) {
                if(text.trim().isEmpty || !text.contains("@")) return "E-mail inválido";
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
                if(text.isEmpty) return "Senha inválida!";
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Endereço"
              ),
              // ignore: missing_return
              validator: (text){
                if(text.trim().isEmpty) return "Endereço inválido";
              },
            ),

            SizedBox(height: 25.0,),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text("Criar conta",
                  style: TextStyle(fontSize: 20.0),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  // pedi para validar os campos quando o botao é pressionando
                  if(_formKey.currentState.validate()){

                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
