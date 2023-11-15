import 'package:flutter/material.dart';
import 'package:autopago/views/sign_up_auth.dart';
import 'package:autopago/widget/input_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../user_auth/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? mensaje;
  bool _isPasswordVisible = false; // Nuevo estado para la visibilidad de la contraseña

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(
                height: 30,
              ),
              _InputCustomized(
                controller: _emailController,
                hintText: 'Correo electrónico',
                labelText: 'E-mail',
                inputType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              const SizedBox(
                height: 30,
              ),
              _InputCustomized(
                controller: _passwordController,
                hintText: 'Contraseña',
                labelText: 'Contraseña',
                inputType: TextInputType.text,
                icon: Icons.lock,
                isPassword: true,
                isPasswordVisible: _isPasswordVisible, // Pasar el estado de visibilidad
                onToggleVisibility: () {
                  // Cambiar el estado de visibilidad al tocar el icono
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿No tienes una cuenta?"),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Registrarme",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25,),

              // Mensaje de error mejorado
              if (mensaje != null)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$mensaje',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print("Login Satisfactorio!!!");
      Navigator.pushReplacementNamed(context, "/");
      setState(() {
        mensaje = null; // Limpiar el mensaje en caso de éxito
      });
    } else {
      setState(() {
        mensaje = "No se encontró el usuario especificado";
      });
    }
  }

  Widget _InputCustomized({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    TextInputType? inputType,
    IconData? icon,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: controller,
        keyboardType: inputType,
        obscureText: isPassword && !isPasswordVisible,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: InputBorder.none,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.blue),
          hintStyle: TextStyle(color: Colors.black45),
          prefixIcon: Icon(
            icon,
            color: Colors.blue,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blue,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}
