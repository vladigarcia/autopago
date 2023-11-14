import 'package:http/http.dart' as http;

Future<void> hacerSolicitudWompi() async {
  final url = Uri.parse('https://id.wompi.sv/connect/authorize');

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer wompi_swaggerui',
      'Content-Type': 'application/json',
    },
    body: '{"parametro1": "valor1", "parametro2": "valor2"}',
  );

  if (response.statusCode == 200) {
    // Procesa la respuesta exitosa aquí
  } else {
    // Maneja errores aquí
    print('Error: ${response.statusCode}');
    print('Respuesta: ${response.body}');
  }
}
