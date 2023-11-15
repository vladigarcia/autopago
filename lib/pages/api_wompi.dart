import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String apiKey = 'e606b79f-6eb9-4a2a-8943-af80f25b9494';
  final String apiUrl = 'https://api.wompi.sv/TransaccionCompra/3DS';

  Future<void> crearTransaccionWompi() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    Map<String, dynamic> body = {
      'amount_in_cents': 1000,
      'currency': 'COP',
      // Add other fields according to the Wompi documentation
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        // Handle success
        print('Transacción exitosa: ${response.body}');
        // You may want to process the response further or navigate to another screen here
      } else {
        // Handle errors
        print('Error en la transacción: ${response.statusCode}');
        print(response.body);
        // You may want to show a user-friendly error message here
      }
    } catch (e) {
      // Handle connection errors
      print('Error de conexión: $e');
      // You may want to show a user-friendly error message here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wompi Pruebas'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call the function to create the transaction when the button is pressed
            crearTransaccionWompi();
          },
          child: Text('Realizar Pago'),
        ),
      ),
    );
  }
}
