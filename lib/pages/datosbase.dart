import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void getClientes() async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("tb_clientes");
  QuerySnapshot mensajes = await collectionReference.get();
  for (var doc in mensajes.docs) {
    print(doc.data());
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is app!',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getClientes();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
