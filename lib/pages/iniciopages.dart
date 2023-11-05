import 'package:flutter/material.dart';

class InicioPages extends StatefulWidget {
  const InicioPages({super.key});

  @override
  State<InicioPages> createState() => _InicioPagesState();
}

class _InicioPagesState extends State<InicioPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
      ),
      body: Column(
        children: <Widget>[
          // Agrega tus widgets de columna aquí
          Text('Widget 1'),
          Text('Widget 2'),
          Text('Widget 3'),
        ],
      ),
    );
  }
}
