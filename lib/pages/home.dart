import 'package:flutter/material.dart';
import 'package:autopago/pages/Agua.dart';
import 'package:autopago/pages/Inicio.dart';
import 'package:autopago/pages/luz.dart';
import 'package:autopago/pages/mas.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        toolbarHeight: 60.0,
        elevation: 4.0,
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
              const SizedBox(width: 10),  // Puedes ajustar el espacio entre el nombre y el ícono
            ],
          ),
        ],
      ),
      body: Center(
        child: _buildPage(_currentIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GNav(
          gap: 8,
          activeColor: Color.fromARGB(255, 0, 0, 0),
          iconSize: 30,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Inicio',
              iconColor: const Color.fromARGB(255, 0, 0, 0),
              backgroundColor: const Color.fromARGB(255, 30, 233, 192), // Color de fondo cuando está seleccionado
            ),
            GButton(
              icon: Icons.water_drop_sharp,
              text: 'Agua',
              iconColor: const Color.fromARGB(255, 0, 0, 0),
               backgroundColor: const Color.fromARGB(255, 30, 233, 192), // Color de fondo cuando está seleccionado
            ),
            GButton(
              icon: Icons.lightbulb,
              text: 'Luz',
              iconColor: const Color.fromARGB(255, 0, 0, 0),
               backgroundColor: const Color.fromARGB(255, 30, 233, 192), // Color de fondo cuando está seleccionado
            ),
            GButton(
              icon: Icons.more_horiz,
              text: 'Más',
              iconColor: const Color.fromARGB(255, 0, 0, 0),
               backgroundColor: const Color.fromARGB(255, 30, 233, 192), // Color de fondo cuando está seleccionado
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return InicioPage();
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
