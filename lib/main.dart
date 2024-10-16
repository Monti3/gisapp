import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/pages/change_password_screen.dart';
import 'package:myapp/pages/saved_exersices_screen.dart';
import '/pages/hello_screen.dart';
import '/pages/home_screen.dart';
import '/pages/login_screen.dart';
import '/pages/signup_screen.dart';
import '/pages/prompter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => const HelloScreen(),
      '/home_screen': (context) => const HomeScreen(),
      '/prompter': (context) => const Prompter(),
      '/hello_screen': (context) => const HelloScreen(),
      '/signup_screen': (context) => const SignupScreen(),
      '/login_screen': (context) =>  LoginScreen(),
      '/change_password_screen': (context) => const ChangePasswordScreen(),
      '/saved_excersices_screen': (context) => const SavedExersicesScreen(),
    });
  }
}
