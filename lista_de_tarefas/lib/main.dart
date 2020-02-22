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

  Map<String, dynamic> _lastRemoved;  //lista de itens removidos
  int _lastRemovePos;

  final toDoController = TextEditingController();

  //ctrl . O = seleciona initState - metodo q carrega as informações ao inicializar o app
  @override
  void initState() {
    super.initState();

    // chama a função para ler os dados
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });

  }

  //_addToDo - criando as tarefas
  void _addToDo(){
    setState(() {  // ************** USADO PARA ATUALIZAR A TELA (NÃO ESQUECER E FICAR SE BATENDO POR CAUSA DISSO, POR FAVOR) **************
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = toDoController.text;   //o map ["title"] recebe o texto do TextField
      toDoController.text = "";   // usado para resetar o texto
      newToDo["ok"] = false;    //acabamos de criar a tarefa e a mesma não foi conluida ainda, por isso o ["ok"] é false
      _toDoList.add(newToDo);   //Adicionando o map na lista
      _saveData();
    });
  }

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
                  controller: toDoController,   //passado as informações para o controlador
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
                  onPressed: _addToDo,
                )
              ],
            ),
          ),


          Expanded(

            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: _toDoList.length,      //pega a quantidade de item na lista
                // ignore: missing_return
                itemBuilder: _buildItem), // ListView é a lista e builder permite criar a lista conforme for construindo a mesma (estilo recyclerView)
          ),
        ],
      ),
    );
  }
  //funcao para retornar
  Widget _buildItem(context, index){    //index é a posição do elemento da lista q esta sendo desenhando
      return Dismissible(   //Dismissible - permite q arrastemos o item para direita para fazer alguma ação
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()), //para chave nao se repetir, pega o tempo atual em mili-segundos
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9 ,0.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        direction: DismissDirection.horizontal,   //Faz o direcionamento de arrastar da esquerda para a direta
        child: CheckboxListTile(        // é a celula da lista q ira exibir as informações setadas
          title: Text(_toDoList[index]["title"]),
          value: _toDoList[index]["ok"],  // se o checkBox está checado ou não
          secondary: CircleAvatar(
            child: Icon(_toDoList[index]["ok"] ? Icons.check: Icons.face),),//Cria um ícone de acerto
          onChanged: (seTaChecado){ //chama funcao quando o status do checkBox muda passando como paramentro bool o seTaChecado
            setState(() {   //atualiza a tela
              _toDoList[index]["ok"] = seTaChecado;   //se seTaChecado = true, selecionando, clica de novo no checkBox e seTaChecado fica falso
              _saveData();  // salva o arquivo quando o status é altarado para ok ou true :)
            });
          },
        ),
        onDismissed: (direction){
          setState(() {
            _lastRemoved = Map.from(_toDoList[index]);    //adiciona o item na lista de itens excluidos pegando a posição
            _lastRemovePos = index;
            _toDoList.removeAt(index);

            _saveData();

            final snack = SnackBar(
              content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
              action: SnackBarAction(label: "Desfazer", onPressed: (){
                setState(() {
                  _toDoList.insert(_lastRemovePos, _lastRemoved);
                  _saveData();
                });
              }),
              duration: Duration(seconds: 3),
            );

            Scaffold.of(context).showSnackBar(snack);

          });

        },  // Ação ao arrastar para direita
      );
    }
  /**/


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
  Future<String> _readData() async {
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
