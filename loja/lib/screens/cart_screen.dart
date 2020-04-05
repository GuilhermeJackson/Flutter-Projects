import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/cart_model.dart';
import 'package:loja/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        // actions = texto q mostra a quantidade de item no carrinho
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            // ScopedModelDescendant<CartModel> = usado para pegar a quantidade de itens do carrinho
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model){
                  int p = model.products.length;
                  return Text(
                    // se p for nulo, ele retorna 0 se nao retorna o valor de p
                    "${p ?? 0} ${p == 1 || p == 0 ? "Item" : "Itens"}",
                    style: TextStyle(fontSize: 17.0)
                  );
                },
            ),
          )
        ],
      ),
      /* ScopedModelDescendant<CartModel> = deve tratar 4 casos
       1 - Se esta carregando alguma coisa
       2 - Se o usuário esta logado ou não
       3 - Se o carrinho esta vazio
       4- Se o usuario tem produto no carrinho deve ser exibido
       */

      body: ScopedModelDescendant<CartModel>(
        // ignore: missing_return
        builder: (context, child, model){
          // 1)
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(
                child: CircularProgressIndicator()
            );
          } else if(!UserModel.of(context).isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor),
                  SizedBox(height: 16.0,),
                  Text("Faça o login para adicionar os produtos!",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,),
                  RaisedButton(
                      child: Text("Entrar", style: TextStyle(fontSize: 18.0),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      })
                ],
              ),
            );
          } else if(model.products == null || model.products.length == 0) {
            return Center(

              child: Padding(padding: EdgeInsets.all(15.0),
                child: Text("Você ainda não tem nenhum produto no seu carrinho :(",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center
                ),
              )

            );
          }
        }
      ),
    );
  }
}
