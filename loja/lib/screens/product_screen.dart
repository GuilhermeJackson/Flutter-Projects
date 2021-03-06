import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja/datas/cart_product.dart';
import 'package:loja/datas/product_data.dart';
import 'package:loja/models/cart_model.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:toast/toast.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String size;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _ProductScreenState(this.product);
  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // AspectRatio = Inserindo tamanho da lista
          AspectRatio(
            aspectRatio: 0.9,
            // Pegando um arrei de imagens do firebase > product
            child: Carousel(
              images: product.images.map((url){
                return NetworkImage(url);
              }).toList(),
              // dotSize = é a boloinha abaixo da imagem q identifica qual imagem do array vc esta
              dotSize: 4.0,
              // dotSpacing = espaço entre as bolinhas
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              // autoplay = faz a imagem passar automaticamente se true
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              // CrossAxisAlignment.stretch = tenta ocupar o maximo de espaço na vertical
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),
                  // maxLines = quantidade maxima de linhas
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                  ),
                ),
                // Espaçamento
                SizedBox(height: 16.0,),
                Text("Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 36.0,
                child: GridView(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.3
                    ),
                  children: product.sizes.map((s){
                    // criando o toc do botao
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          size = s;
                        });
                      },
                      child: Container(
                        // deixando o botao redondo
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: Border.all(
                            // se o botao for selecionado fica primaryColor se não cinza
                            color: s == size ? primaryColor : Colors.grey[500],
                            width: 3.0,
                          ),
                        ),
                        // arruamdno o texto dentro do botao
                        width: 50.0,
                        alignment: Alignment.center,
                        child: Text(s),
                      ),
                    );
                  }).toList(),
                ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(onPressed: size != null ?
                      (){
                            // UserModel.of(context).isLoggedIn() = verifica se usuario esta logado
                          if(UserModel.of(context).isLoggedIn()){
                            //Adicionar ao carrinho
                            CartProduct cartProduct = CartProduct();
                            cartProduct.size = size;
                            cartProduct.quantity = 1;
                            cartProduct.pid = product.id;
                            cartProduct.category = product.category;

                            Toast.show("Um produto adicionado no carrinho!!!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=> CartScreen())
                            );



                            CartModel.of(context).addCartItem(cartProduct);
                          } else {
                            //se nao abreu tela de login
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>LoginScreen())
                            );
                          }
                      } : null,
                  child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao carrinho"
                    : "Faça o login para comprar",
                    style: TextStyle(fontSize: 18.0),
                  ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text("Descrição ",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(product.description, style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _messageAddingProductInCart(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Um produto adicionado no carrinho!!!"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3)
        )
    );
  }


}
