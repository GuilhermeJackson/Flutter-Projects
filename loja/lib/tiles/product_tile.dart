import 'package:flutter/material.dart';
import 'package:loja/datas/product_data.dart';
import 'package:loja/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;
  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    //InkWell = mesma coisa q GestureDetector só q realiza uma animação diferente
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ProductScreen(product))
        );
      },
      child: Card(
        // se type for igual a "grid" recebe uma Column(), se não recebe uma Row()
        child: type == "grid" ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //AspectRatio = nao varia conforme o tipo de aparelho
              AspectRatio(
                aspectRatio: 0.8,
                child: Image.network(product.images[0],
                // fit: BoxFit.cover = conteudo cobre todo o card
                fit: BoxFit.cover,)
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(product.title,
                      style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("R\$" + product.price.toStringAsFixed(2),
                      style: TextStyle(color: Theme.of(context).primaryColor,
                      fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
              )
            ],
          )
            : Row(
          children: <Widget>[
            // fazendo a linha ser dividia exatamente no meio
            Flexible(
              flex: 1,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
                height: 250.0,),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(product.title,
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text("R\$" + product.price.toStringAsFixed(2),
                      style: TextStyle(color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
