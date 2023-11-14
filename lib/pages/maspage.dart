import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildSection(
              Icons.home,
              'General',
              ['Información personal', 'Ajustes', 'Mis cuentas'],
            ),
            buildSection(
              Icons.settings,
              'Contacto',
              ['Contáctanos', 'Invitar amigos'],
            ),
            buildSection(
              Icons.info,
              'Soporte',
              ['Términos y condiciones', 'Política de privacidad'],
            ),
            SizedBox(height: 16), // Espacio entre las secciones y el botón "Cerrar Sesión"
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/login");
                } catch (e) {
                  // Manejar posibles errores aquí, por ejemplo, mostrar un mensaje de error.
                  print("Error al cerrar sesión: $e");
                }
              },
              child: Text(
                'Cerrar Sesión',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 54, 244, 162)),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget buildSection(IconData icon, String title, List<String> items) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              // Acción al presionar el botón
            },
            icon: Icon(
              icon,
              size: 48,
            ),
            label: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          for (String item in items)
            ListTile(
              title: Text(
                item,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Acción al tocar un elemento de la lista
              },
            ),
        ],
      ),
    );
  }
}
