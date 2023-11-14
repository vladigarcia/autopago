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
  String userName = 'usuario';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0, // Establece la altura del AppBar según tus preferencias
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text(
                userName,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightGreen,
                  ),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('images/perfil.png'),
                  ),
                ),
              ),
            ],
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
        items: const [
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
        selectedLabelStyle: const TextStyle(fontSize: 14.0),
        unselectedLabelStyle: const TextStyle(fontSize: 14.0),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const InicioPages();
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
