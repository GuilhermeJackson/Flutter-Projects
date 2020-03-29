import 'package:flutter/material.dart';

import 'buscando_gifs/ui/home_page.dart';
import 'list_projects.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projects Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 150, 220)
      ),
        debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project's Flutter"),
        centerTitle: true,
      ),
      body: ListProjects()
    );
  }
}

