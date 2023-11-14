import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PagoLuzPage extends StatefulWidget {
  @override
  _PagoLuzPageState createState() => _PagoLuzPageState();
}

class _PagoLuzPageState extends State<PagoLuzPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String electricityBillMessage = '';
  double electricityBillAmount = 0.0;
  DateTime dueDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchElectricityBillData();
  }

  Future<void> fetchElectricityBillData() async {
    try {
      final DocumentSnapshot electricityBillData =
          await firestore.collection('tb_recibodeluz').doc('documento_id').get();

      if (electricityBillData.exists) {
        final data = electricityBillData.data() as Map<String, dynamic>;
        setState(() {
          electricityBillMessage = data['mensaje'];
          electricityBillAmount = data['monto'];
          dueDate = data['fecha_vencimiento'].toDate();
        });
      } else {
        setState(() {
          electricityBillMessage = 'No se encontraron datos';
        });
      }
    } catch (e) {
      print('Error al recuperar datos: $e');
      setState(() {
        electricityBillMessage = 'Error al recuperar datos';
      });
    }
  }

  // Aquí puedes implementar la lógica para el pago automático y recordatorios

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago de Luz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(''),
            SizedBox(height: 20),
            Text('Mensaje: $electricityBillMessage'),
            Text('Monto: \$$electricityBillAmount'),
            Text('Fecha de Vencimiento: ${dueDate.toLocal()}'),
            // Aquí puedes agregar botones y lógica para el pago y recordatorios
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PagoLuzPage(),
  ));
}
