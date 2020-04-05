import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/datas/cart_product.dart';
import 'package:loja/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{
  UserModel user;
  List<CartProduct> products = [];

  bool isLoading = false;

  // Maneira mais pratica de acessar o CartModel
  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  CartModel(this.user);

  void addCartItem (CartProduct cartProduct){
    products.add(cartProduct);
    // toMap() = é uma funcao para poder armazenar no banco de dados do firebase
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").add(cartProduct.toMap()).then((doc){
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).delete();

    products.remove(cartProduct);

    notifyListeners();
  }
}