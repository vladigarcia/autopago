import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Colores personalizados
const Color verdeClaro = Color(0xFF4CAF50);
const Color celesteClaro = Color(0xFF3F51B5);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: verdeClaro,
        hintColor: celesteClaro,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.grey[200], // Background color
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: celesteClaro,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const InicioPages(),
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
        studentInfo.add("${data['Monto']} - ${data['Fecha vencimiento']} - ${data['Metodos de pago']} - ${data['recordatorios']}");
      }
      setState(() {
        studentData = studentInfo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 2,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 10),
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
                const Text(
                  '\$500.00',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: verdeClaro,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: studentData.length,
              itemBuilder: (context, index) {
                List<String> values = studentData[index].split(' -');
                return Card(
                  margin: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          leading: const Icon(Icons.attach_money),
                          title: Text(
                            'Monto: ${values[0]}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          leading: const Icon(Icons.calendar_today),
                          title: Text('Fecha de vencimiento: ${values[1]}'),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          leading: const Icon(Icons.payment),
                          title: Text('Métodos de pago: ${values[2]}'),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          leading: const Icon(Icons.notifications),
                          title: Text('Recordatorios: ${values[3]}'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
            ],
          ),
        ],
      ),
    );
  }
}
