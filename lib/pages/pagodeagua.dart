import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PagoAguaPage extends StatefulWidget {
  @override
  _PagoAguaPageState createState() => _PagoAguaPageState();
}

class _PagoAguaPageState extends State<PagoAguaPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago de Agua'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: fetchWaterBillData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos.
          } else if (snapshot.hasError) {
            return Text('Error al recuperar datos: ${snapshot.error}');
          } else {
            if (snapshot.hasData) {
              final waterBillData = snapshot.data?.data() as Map<String, dynamic>;
              final waterBillMessage = waterBillData['mensaje'];
              final waterBillAmount = waterBillData['monto'];
              final dueDate = waterBillData['fecha_vencimiento'].toDate();

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Mensaje: $waterBillMessage'),
                    Text('Monto: \$$waterBillAmount'),
                    Text('Fecha de Vencimiento: ${dueDate.toLocal()}'),
                    // Aquí puedes agregar botones y lógica para el pago y recordatorios
                  ],
                ),
              );
            } else {
              return Text('No se encontraron datos');
            }
          }
        },
      ),
    );
  }

  Future<DocumentSnapshot> fetchWaterBillData() {
    return firestore.collection('tb_recibodeagua').doc('documento_id').get();
  }
}

void main() {
  runApp(MaterialApp(
    home: PagoAguaPage(),
  ));
}
