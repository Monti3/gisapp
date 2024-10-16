import 'package:flutter/material.dart';
import 'package:myapp/temps/fillzonne_temp.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      
      backgroundColor: Colors.white,      
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: height / 10),
                const Text(
                  'Bienvenido',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                const Text(
                  'Ingresa tus datos',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: height / 10),
                FillZone(_mailController, 'Email', false),
                const SizedBox(
                  height: 10,
                ),
                FillZone(_passwordController, 'Contraseña', true),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.black),
                  child: Container(
                    decoration: const BoxDecoration(),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        AuthService authService = AuthService();
                        await authService.login(
                            email: _mailController.text,
                            password: _passwordController.text,
                            context: context);
                      },
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Olvidaste tu contraseña?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/change_password_screen');
                        },
                        child: const Text(
                          'Cambiala acá',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
