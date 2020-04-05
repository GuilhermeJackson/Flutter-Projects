import 'package:flutter/material.dart';
import 'package:loja/tabs/HomeTab.dart';
import 'package:loja/tabs/ProductsTab.dart';
import 'package:loja/widgets/CustomDrawer.dart';
import 'package:loja/widgets/cart_button.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          // chamando o botao do carrinho
          floatingActionButton: CartButton(),
        ),
        //Passando para tela de cerveja
        Scaffold(
          appBar: AppBar(
              title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
            body: (ProductsTab( )),
          // chamando o botao do carrinho
          floatingActionButton: CartButton(),
        ),
        Container(color: Colors.blue),
        Container(color: Colors.pink),
      ],
    );
  }
}
