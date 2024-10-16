import 'package:flutter/material.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/temps/appbar_temp.dart';
import 'package:myapp/temps/fillzonne_temp.dart';
import 'package:myapp/temps/textbutton_temp.dart';
import 'package:myapp/services/auth_service.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarTemp(context, 'Crear cuenta'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            FillZone(controllerEmail, 'Email', false),
            const SizedBox(
              height: 10,
            ),
            FillZone(controllerPassword, 'Contraseña', true),
            TextButton(
                onPressed: () async {
                  AuthService authService = AuthService();
                  await authService.signup(
                    email: controllerEmail.text,
                    password: controllerPassword.text,
                    context: context
                  );
                },
                child: const Text('Crear cuenta'))
          ],
        ),
      ),
    );
  }
}
