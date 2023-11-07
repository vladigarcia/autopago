import 'package:flutter/material.dart';
import 'package:autopago/pages/Energypage.dart';
import 'package:autopago/pages/iniciopages.dart';
import 'package:autopago/pages/maspage.dart';
import 'package:autopago/pages/watherpages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: _buildPage(_currentIndex),
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
            icon: Icon(Icons.water_drop_sharp),
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
        iconSize: 30.0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 14.0),
        unselectedLabelStyle: TextStyle(fontSize: 14.0),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // Cambia el color de fondo
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return InicioPages();
      case 1:
        return AguaPage();
      case 2:
        return LuzPage();
      case 3:
        return MasPage();
      default:
        return Container();
    }
  }
}
