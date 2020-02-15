import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';    // Requisição de um modo que não precise esperar a requisição estar completa
import 'dart:convert'; //Usado para converte algo em Json

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=fcb552cb";   // URL da API

void main() async {
  http.Response response = await http.get(request);//manda o get para o servido com a url do request e retorna quando os dados chegar do servidor
  print(json.decode(response.body) ["results"] ["currencies"] ["USD"]);

  runApp(MaterialApp(
  home: Container(

  )
));
}