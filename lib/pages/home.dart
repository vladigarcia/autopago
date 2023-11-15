import 'package:flutter/material.dart';
import 'package:autopago/pages/Agua.dart';
import 'package:autopago/pages/Inicio.dart';
import 'package:autopago/pages/luz.dart';
import 'package:autopago/pages/mas.dart';
import 'package:autopago/pages/user.dart'; // Asegúrate de importar la clase UserPage desde user.dart
import 'package:google_nav_bar/google_nav_bar.dart';

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
        toolbarHeight: 60.0,
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navegar a la página de perfil al hacer clic en el ícono de perfil
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage1()), // Asegúrate de tener una ruta definida para UserPage en tu aplicación
              );
            },
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
              backgroundColor: const Color.fromARGB(255, 30, 233, 192),
            ),
            GButton(
              icon: Icons.water_drop_sharp,
              text: 'Agua',
              iconColor: const Color.fromARGB(255, 0, 0, 0),
              backgroundColor: const Color.fromARGB(255, 30, 233, 192),
            ),
            GButton(
              icon: Icons.lightbulb,
              text: 'Luz',
              iconColor: const Color.fromARGB(255, 0, 0, 0),
              backgroundColor: const Color.fromARGB(255, 30, 233, 192),
            ),
            GButton(
              icon: Icons.more_horiz,
              text: 'Más',
              iconColor: const Color.fromARGB(255, 0, 0, 0),
              backgroundColor: const Color.fromARGB(255, 30, 233, 192),
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
        return const InicioPages();
      case 1:
        return AguaPage();
      case 2:
        return LuzPage();
      case 3:
        return const SettingsPage2();
      default:
        return Container();
    }
  }
}
