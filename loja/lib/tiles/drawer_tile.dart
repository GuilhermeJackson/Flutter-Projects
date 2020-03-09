import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    //Nesse caso é usado Material para ocorrer o efeito ao clicar nos textos do drawler
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(icon,
              size: 32.0,
              // a opção do drawer fica cinza se sua respectiva página estiver sido selecionada (round() é usado para arrendondar o double)
              color: controller == page.round() ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 32.0,),
              Text(text, style: TextStyle(
                fontSize: 16.0,
                  // a opção do drawer fica cinza se sua respectiva página estiver sido selecionada
                color: controller == page.round() ? Theme.of(context).primaryColor : Colors.grey[700]
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
