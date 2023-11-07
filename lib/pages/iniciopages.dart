import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF3F51B5),
        hintColor: Color(0xFF4CAF50),
        fontFamily: 'Montserrat',
      ),
      home: InicioPages(),
    ),
  );
}

class InicioPages extends StatefulWidget {
  const InicioPages({Key? key}) : super(key: key);

  @override
  State<InicioPages> createState() => _InicioPagesState();
}

class _InicioPagesState extends State<InicioPages> {
  List<String> studentData = [];

  @override
  void initState() {
    super.initState();
    getRecibodeLuz();
  }

  Future<void> getRecibodeLuz() async {
    CollectionReference studentsCollection =
        FirebaseFirestore.instance.collection("tb_recibodeluz");
    QuerySnapshot querySnapshot = await studentsCollection.get();

    if (querySnapshot.docs.isNotEmpty) {
      final List<DocumentSnapshot> documents = querySnapshot.docs;
      final List<String> studentInfo = [];
      for (var document in documents) {
        final data = document.data() as Map<String, dynamic>;
        studentInfo
            .add("${data['Monto']} - ${data['Fecha vencimiento']} - ${data['Metodos de pago']} - ${data['recordatorios']}");
      }
      setState(() {
        studentData = studentInfo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0, // Establece la elevación a 0 para que la AppBar esté en la parte superior
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/credit.png',
                      width: 300,
                      height: 200,
                    ),
                  ],
                ),
                Text(
                  '\$500.00',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F51B5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: studentData.map((data) {
                  List<String> values = data.split(' -');
                  return Card(
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.money),
                            title: Text('Monto: ${values[0]}'),
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text('Fecha de vencimiento: ${values[1]}'),
                          ),
                          ListTile(
                            leading: Icon(Icons.payment),
                            title: Text('Métodos de pago: ${values[2]}'),
                          ),
                          ListTile(
                            leading: Icon(Icons.notifications),
                            title: Text('Recordatorios: ${values[3]}'),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Acción cuando se presiona el primer botón
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF3F51B5),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Pago de Agua'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Acción cuando se presiona el segundo botón
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4CAF50),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Pago de Energía'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
