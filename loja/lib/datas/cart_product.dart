import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/datas/product_data.dart';

class CartProduct{

  //Não é viavel armazenar imagem, nome, preço e etc.. do produto pois o mesmo pode seur alterado enquanto o produto esta no carrinho ou em outro estado

  //id da categoria
  String cid; //id do carrinho
  String category;
  //id do produto
  String pid; // id do produto
  int quantity;
  String size;

  ProductData productData;

  // Construtor vazio
  CartProduct();

  // Contrutor - produto no carrinho
  CartProduct.fromDocument(DocumentSnapshot document){
   cid = document.documentID;
   category = document.data["category"];
   pid = document.data["pid"];
   quantity = document.data["quantity"];
   size = document.data["size"];
  }

  //Adicionando no banco de dados
  Map<String, dynamic> toMap(){
    return {
      "category" : category,
      "pid" : pid,
      "quantity" : quantity,
      "size" : size,
      // Armazena um resumo
      //"product" : productData.toResumeMap()

    };
  }

}