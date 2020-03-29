import 'package:flutter/material.dart';
import 'buscando_gifs/ui/home_page.dart';
import 'calculando_imc/main_imc.dart';
import 'chat_online/main_chat.dart';
import 'conversor_de_moeda/main_conversor.dart';
import 'lista_de_tarefa/main_lista_de_tarefa.dart';

class ListProjects extends StatefulWidget {
  @override
  _ListProjectsState createState() => _ListProjectsState();
}

class _ListProjectsState extends State<ListProjects> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 10.0, left: 10.0),
      children: <Widget>[
        ListTile(
          title: Text("Buscando gifs",style: TextStyle(
              fontSize: 23.0, fontStyle: FontStyle.italic),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>HomePageGifs())
            );
          },
        ),
        ListTile(
          title: Text("Calculando IMC",style: TextStyle(
              fontSize: 23.0, fontStyle: FontStyle.italic),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>HomeIMC())
            );
          },
        ),
        ListTile(
          title: Text("Chat online",style: TextStyle(
              fontSize: 23.0, fontStyle: FontStyle.italic),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>MyApp())
            );
          },
        ),
        ListTile(
          title: Text("Conversor de moeda",style: TextStyle(
              fontSize: 23.0, fontStyle: FontStyle.italic),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>HomeConversor())
            );
          },
        ),
        ListTile(
          title: Text("Lista de tarefas",style: TextStyle(
              fontSize: 23.0, fontStyle: FontStyle.italic),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>HomeListaDeTarefa())
            );
          },
        ),
        ListTile(
          title: Text("Loja online",style: TextStyle(
              fontSize: 23.0, fontStyle: FontStyle.italic),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){

          },
        ),
      ],
    );
  }
}
