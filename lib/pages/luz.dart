import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LuzPage extends StatelessWidget {
  final String clientId = '3869d3f2-a14e-4abf-ae66-a0af4a31becd';
  final String clientSecret = 'e606b79f-6eb9-4a2a-8943-af80f25b9494';
  String accessToken =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6Ik40RjVNczJtNFJxWDduMTE0TFhoTEEiLCJ0eXAiOiJhdCtqd3TifQ.eyJuYmYiOjE3MDAwMjQxNDEsImV4cCI6MTcwMDAyNzc0MSwiaXNzIjoiaHR0cHM6Ly9pZC53b21waS5zdiIsImF1ZCI6WyJodHRwczovL2lkLndvbXBpLnN2L3Jlc291cmNlcyIsIndvbXBpX2FwaSJdLCJjbGllbnRfaWQiOiIzODY5ZDNmMi1hMTRlLTRhYmYtYWU2Ni1hMGFmNGEzMWJlY2QiLCJzY29wZSI6WyJ3b21waV9hcGkiXX0.M92MbyORv3XQcCenO9TWL-wcpxKbwBrZS6B6SUEEiAehzs7bwzuDJwKGlzYeBktN01YUO-df7oXij6pCQwz86MYE9fvqxAbqkWk8z7sEeLKs34doFyw_4n9Eapsce3GInoCzasLzXJEvchUgWa3eK1iAd1Qo3U7RECqBQQpAaeLfQ_cTrEqA7JfJWmgrZ17FkHLBnzBPC6JM4nDzAuDflpJqP6Z1vAHhD6ZVG6zHjPaQ1nDy3s1F1DKeFqL5UdVKFbyFaAFqneiTvPt5mycOFjajJU0NoGfzrwD8VzpRDCpO3mdzc9y34KulrNcErZTsv9KSCygzWCjp_VoMxGVN6A'; // Guarda el token de acceso aquí

  Future<void> _obtenerTokenAcceso() async {
    try {
      var response = await http.post(
        Uri.parse('https://id.wompi.sv/connect/token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        },
        body: {
          'grant_type': 'client_credentials',
        },
      );

      print('Respuesta del token de acceso: ${response.statusCode}');
      print(response.body);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        accessToken = responseData['access_token'];
      } else {
        print('Error al obtener el token de acceso: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<String?> _obtenerToken3DS() async {
    try {
      await _obtenerTokenAcceso(); // Obtén el token de acceso antes de la solicitud de token 3DS

      var response = await http.post(
        Uri.parse('https://api.wompi.sv/Aplicativo'), // Corregir la URL
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json', // Cambia el tipo de contenido
        },
        body: {
          'card_number': '58348692348692659', // Número de tarjeta de prueba
          'expiration_month': '30', // Mes de vencimiento de prueba
          'expiration_year': '2030', // Año de vencimiento de prueba
          'cvc': '464', // CVC de prueba
          // Otros parámetros según la documentación de Wompi
        },
      );

      print('Respuesta del token 3DS: ${response.statusCode}');
      print(response.body);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        return responseData['token_3ds'] as String?;
      } else {
        print('Error al obtener el token 3DS: ${response.statusCode}');
        print(response.body);
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  Future<void> _procesarPagoCon3DS(String token3DS) async {
    try {
      var response = await http.post(
        Uri.parse('https://api.wompi.sv/TransaccionCompra/3DS'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount_in_cents': 2500,
          'currency': 'USD',
          'token_3ds': token3DS,
          // Otros parámetros según la documentación de Wompi
        }),
      );

      print('Respuesta del pago con 3DS: ${response.statusCode}');
      print(response.body);

      if (response.statusCode == 200) {
        print('Pago exitoso');
        // Puedes manejar la respuesta aquí
      } else {
        print('Error al procesar el pago con 3DS: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _procesarPagoOtrosMetodos() async {
    // Abre el enlace usando url_launcher
    String url = 'https://lk.wompi.sv/rksq';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('No se pudo abrir el enlace: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 79, 233, 84),
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
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 210, 228, 105), const Color.fromARGB(255, 164, 164, 164)],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 700,
              height: 100,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Pago de Recibo de Luz',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            _buildPaymentButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Aquí puedes llamar a la función relacionada con el pago de Wompi
            // Por ejemplo, puedes llamar a _procesarPagoCon3DS() y manejar el pago con Wompi.
            // Asegúrate de implementar la lógica adecuada para el pago con Wompi.
          },
          child: Text(
            'Pagar con Wompi',
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 201, 243, 33), // Color del botón
            onPrimary: Colors.white, // Color del texto
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: () {
            _procesarPagoOtrosMetodos(); // Manejar otros métodos de pago o abrir enlaces
          },
          child: Text(
            'Otros métodos de pago',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LuzPage(),
  ));
}
