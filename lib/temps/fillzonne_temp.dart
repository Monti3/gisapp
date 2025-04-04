import 'package:flutter/material.dart';

class FillZone extends StatelessWidget {
  FillZone(this.controller, this.text, this.isPassword, this.icon, {super.key});

  TextEditingController controller = TextEditingController();
  final String text; 
  final bool isPassword;
  final Icon icon; 
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2466219982.

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                labelText: text,
                labelStyle: TextStyle(color: Colors.black),
                border: const OutlineInputBorder(), // Borde normal
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color y ancho del borde al estar enfocado
                ),
                focusColor: Colors
                    .black, // Esto solo afecta el color de la barra de enfoque en el label
              ),
                obscureText: isPassword,
                cursorColor: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}