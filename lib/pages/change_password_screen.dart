import 'package:flutter/material.dart';
import 'package:myapp/temps/appbar_temp.dart';
import 'package:myapp/temps/fillzonne_temp.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    final height = MediaQuery.of(context).size.height;

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
                    'Primero, verifiquemos el correo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  FillZone(controller1, 'Email ', false),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {},
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Verificar correo',
                          style: TextStyle(color: Colors.black),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
