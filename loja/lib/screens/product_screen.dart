import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;


  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String size;
  _ProductScreenState(this.product);
  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
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
                            width: 4.0,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
