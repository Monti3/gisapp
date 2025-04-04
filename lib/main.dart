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
import 'package:firebase_auth/firebase_auth.dart';

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
      '/': (context) => AuthChecker(),
      '/home_screen': (context) => const HomeScreen(),
      '/prompter': (context) => const Prompter(),
      '/hello_screen': (context) => const HelloScreen(),
      '/signup_screen': (context) => const SignupScreen(),
      '/login_screen': (context) => LoginScreen(),
      '/change_password_screen': (context) => const ChangePasswordScreen(),
      '/saved_excersices_screen': (context) => const SavedExersicesScreen(),
    });
  }
}

class AuthChecker extends StatefulWidget {
  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      _user = auth.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user != null) {
      return HomeScreen(); // Redirigir a la pantalla principal si el usuario está autenticado
    } else {
      return LoginScreen(); // Mostrar la pantalla de inicio de sesión si no está autenticado
    }
  }
}
