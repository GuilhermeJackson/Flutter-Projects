import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {

  runApp(MyApp());
  // Esperando os dados para inserir no snapshot
  //DocumentSnapshot snapshot = await Firestore.instance.collection("menssagens").document("msg1").get();

  // Snapshot recebe uma foto exato do momento do banco
  //QuerySnapshot snapshot = await Firestore.instance.collection("menssagens").getDocuments();

  // Sempre que houver uma mudança, uma função é chamada
  Firestore.instance.collection("menssagens").snapshots().listen((snapshot){
    for (DocumentSnapshot doc in snapshot.documents) {
      print(doc.data);
    }
  });



}

class MyApp extends StatelessWidget {
//Definindo a cor padrão de varios componentes
  final ThemeData KIOSTheme = ThemeData(
      primarySwatch: Colors.orange,
      //Tonalidade
      primaryColor: Colors.grey[300],
      //Brilho
      primaryColorBrightness: Brightness.light
  );
//Definindo a cor padrão de varios componentes
  final ThemeData KDefaultTheme = ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400],
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Nem a NASA rastreia...",
      // Remover a faixa de debug da tela do app
      debugShowCheckedModeBanner: false,
       // Define um tema se for iphone e outro tema se for android
       theme: Theme.of(context).platform == TargetPlatform.iOS ? KIOSTheme : KDefaultTheme,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // SafeArea - ignora as barrinhas do iPhone e android (barra com botao de voltar e minimizar os app e tal)
    return SafeArea(
        bottom: false,
        top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat App"),
          centerTitle: true,
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: TextComposer(

              ),
            ),
          ],
        ),
      ),
    );

  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        // Inserir o const no na margin, deixa o app mais leve
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: Theme.of(context).platform  == TargetPlatform.iOS ? BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[200]))
        ) : null,
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: (){},
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: "Escreva sua mensagem..."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
