import 'package:flutter/material.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          
          children: [
            Image.asset('assets/gisapplogo.png'),
            const Text(
              'Hola',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const SizedBox(
              height: 30,
            ),
            const Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children :[OptionButton(
                'Iniciar Sesión',
                null,
                Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                '/login_screen'),

            OptionButton('Crear Cuenta', 'Si no tenés una cuenta, creá una',
                null, '/signup_screen')])
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton(this.title, this.description, this.icon, this.route,
      {super.key});

  final String title;
  final String? description;
  final String route;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButtonTemp(route: route, icon: icon, title: title),
    );
  }
}

class TextButtonTemp extends StatelessWidget {
  const TextButtonTemp({
    super.key,
    required this.route,
    required this.icon,
    required this.title,
  });

  final String route;
  final Icon? icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: SizedBox(
        height: 45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: icon ??
                            icon), // si icon no es null, se agrega como child
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                   
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
