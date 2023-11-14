import 'package:flutter/material.dart';

class LuzPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 243, 33),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            Align(
              alignment: Alignment(0, 0.3),
              child: Image.asset(
                'images/rayo.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 55),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _buildRoundedCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      elevation: 6,
      margin: EdgeInsets.all(1),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: 700,
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Formulario de Pago de Recibo de Energia',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          _buildForm(),
          _buildTransitions(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Número de Cuenta de Energia',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(fontSize: 16, color: Colors.black), // Estilo para la etiqueta
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ), // Estilo del borde cuando el campo está enfocado
          ),
          style: TextStyle(fontSize: 18, color: Colors.black), // Estilo del texto dentro del campo
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Monto a Pagar',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(fontSize: 16, color: Colors.black), // Estilo para la etiqueta
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ), // Estilo del borde cuando el campo está enfocado
          ),
          style: TextStyle(fontSize: 18, color: Colors.black), // Estilo del texto dentro del campo
        ),
        ElevatedButton(
          onPressed: () {
            // Agregar lógica para procesar el pago del recibo de agua
            // Aquí puedes obtener los valores de los campos de texto y procesar el pago.
          },
          child: Text('Pagar'),
        ),
      ],
    );
  }

  Widget _buildTransitions() {
    return Column(
      children: [
        Text('Información de Transiciones:'),
        Text('Nombre: Cecilia del Carmen'),
        Text('Monto: \$25'),
      ],
    );
  }
}
