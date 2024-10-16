import 'package:flutter/material.dart';

class FillZone extends StatelessWidget {
  FillZone(this.controller, this.text, this.isPassword, {super.key});

  TextEditingController controller = TextEditingController();
  final String text; 
  final bool isPassword;
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
                  hintText: text,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.person,
                  ),
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