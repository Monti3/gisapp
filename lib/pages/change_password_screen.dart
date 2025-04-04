import 'package:flutter/material.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/temps/appbar_temp.dart';
import 'package:myapp/temps/fillzonne_temp.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller1 = TextEditingController();

    @override
    void dispose() {
      controller1.dispose();
      super.dispose();
    }

    final height = MediaQuery.of(context).size.height;
    AuthService authService = AuthService();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarTemp(context, 'Cambiar contraseña'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: height * 0.1),
                  const Text(
                    'Ingrese su correo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  FillZone(controller1, 'Email ', false, Icon(Icons.person)),
                  const SizedBox(height: 5),
                  TextButton(
                      onPressed: () {
                        authService.passwordReset(
                          email: controller1.text.trim(), context: context);
                      },
                      child: const Text(
                        'Verificar correo',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
