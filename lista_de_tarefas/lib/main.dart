import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = []; //criando uma lista
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(    //usado para dar espaçamento RaisedButton ficarem alinhados
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[

                Expanded(   // Usado para o TextField e RaisedButton ficarem alinhados

                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Nova tarefa",
                        labelStyle: TextStyle(color: Colors.blue)
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text("Add"),
                  textColor: Colors.white,
                  onPressed: (){

                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //Usado para pegar o caminho do diretorio do dispositivo
  Future<File> _getFile() async {
    //async é usado quando não conseguimos ter os dados instantaniamente
    //getApplicationDocumentsDirectory - pega o diretorio de armazenamento do dispositivo mobile android ou ios por causa da lib path_provider
    final directory = await getApplicationDocumentsDirectory();
    return File(
        "${directory.path}/data.json"); //retorna um arquivo com caminho especificado com o nome de data.json
  }

//Usado para salvar os dados no arquivo
  Future<File> _saveData() async {
    //async é usado quando não conseguimos ter os dados instantaniamente
    String data = json.encode(
        _toDoList); //Trasformando a list em um json e armazenando na String 'data'
    final file =
        await _getFile(); //Espera o _getFile retorna o diretorio para salvat do constante file
    return file.writeAsString(
        data); // pega o arquivo e com a lista de tarefas e escreve como texto
  }

  //Usado para ler os dados do arquivo
  Future<String> _data() async {
    //async é usado quando não conseguimos ter os dados instantaniamente
    try {
      final file =
          await _getFile(); //Espera o _getFile retorna o diretorio para salvat do constante file
      return file.readAsString(); //Le o arquivo para poder retorna
    } catch (e) {
      return null;
    }
  }
}
