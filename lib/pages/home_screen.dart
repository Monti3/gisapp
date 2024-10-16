import 'package:flutter/material.dart';
import 'package:myapp/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'gisapp',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Image.asset('assets/gisapplogo.png'),
        const OptionButton(
            'Generar ejercicios',
            null,
            Icon(Icons.auto_awesome, color: Colors.white),
            '/prompter',
            null),
        const OptionButton(
            'Mis ejercicios',
            null,
            Icon(Icons.assignment_rounded, color: Colors.white),
            '/saved_excersices_screen',
            null),
         OptionButton(
            'Salir', null, const Icon(Icons.exit_to_app, color: Colors.white), null, () async{
          AuthService authService = AuthService();
          await authService.logout(context: context);
        })
      ]),
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton(this.title, this.description, this.icon, this.route, this.pressedFunction, {super.key});

  final String title;
  final String? description;
  final String? route;
  final Icon icon;
  final Function? pressedFunction;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0)
      ),
      onPressed: () {
        if (pressedFunction != null) {
          pressedFunction!();
        } else if (route != null) {
          Navigator.pushNamed(context, route!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          color: Colors.black,
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 4),
                Align(alignment: Alignment.centerLeft, child: icon),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.white),
                    ),
                    if (description != null) Text(
                      '$description',
                      style: const TextStyle(fontWeight: FontWeight.w300)
                    ) 
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

