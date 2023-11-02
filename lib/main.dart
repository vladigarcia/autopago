import 'package:autopago/firebase_options.dart';
import 'package:autopago/pages/datosbase.dart';
import 'package:autopago/pages/home.dart';
import 'package:autopago/views/login_page.dart';
import 'package:autopago/views/sign_up_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       initialRoute: "/login",
      routes: {

        "/login":(context) => const LoginPage(),
        "/signup":(context) => const SignUpPage(),
        

      },
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

