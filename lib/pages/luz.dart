import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: LuzPage(),
  ));
}

class LuzPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 60, 247, 138),
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
            colors: [Color.fromRGBO(234, 218, 76, 1), Color.fromARGB(255, 242, 242, 242)],
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
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.center,
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
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Launch the URL when the button is pressed
            _launchInBrowser(Uri.parse('https://lk.wompi.sv/hjKj'));
          },
          child: Text(
            'Pagar con Wompi',
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 27, 61, 94),
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
        ),
      ],
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
