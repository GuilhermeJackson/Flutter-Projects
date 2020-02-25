import 'package:flutter/material.dart';
import 'package:share/share.dart';


 class gif_page extends StatelessWidget {
   // Informação coletada da home_page
   Map _gifData;

   //Esse é o construtor
   gif_page(this._gifData);

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(_gifData["title"]),
         backgroundColor: Colors.black,
         //Criando as opções de compartilhamentos
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.share),
             onPressed: ( ) {
              Share.share(_gifData["images"]["fixed_height"]["url"]);
             },
           )
         ],
       ),
       backgroundColor: Colors.black,
       body: Center(
         child: Image.network(_gifData["images"]["fixed_height"]["url"]),
       ),
     );
   }
 }
 