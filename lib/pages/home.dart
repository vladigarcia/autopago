import 'package:autopago/pages/Energypage.dart';
import 'package:autopago/pages/iniciopages.dart';
import 'package:autopago/pages/maspage.dart';
import 'package:autopago/pages/watherpages.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Para llevar un seguimiento de la pestaña seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('URL_DE_TU_IMAGEN_DE_PERFIL'),
            ),
          ),
        ],
      ),
      body: Center(
        child: _buildPage(_currentIndex), // Mostrar la página actual
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Agua',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Luz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Más',
          ),
        ],
        iconSize: 24.0, // Ajusta el tamaño de los iconos
        selectedItemColor: Colors.blue, // Color de los iconos seleccionados
        unselectedItemColor: Colors.grey, // Color de los iconos no seleccionados
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
      return InicioPages();
      case 1:
        return AguaPage(); // Página de agua
      case 2:
        return LuzPage(); // Página de luz
      case 3:
        return MasPage(); // Página de más
      default:
        return Container(); // Página por defecto
    }
  }
}
