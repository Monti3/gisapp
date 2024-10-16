import 'package:flutter/material.dart';

class TextButtonTemp extends StatelessWidget {
  const TextButtonTemp({
    super.key,
    required this.route,
    required this.icon,
    required this.title,
    required this.context,
  });

  final String route;
  final Icon? icon;
  final String title;
  final BuildContext context; 

  @override
  Widget build(context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: SizedBox(
        height: 45,
        width: double.infinity, // Ocupa todo el ancho disponible
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: icon!,
                    ),
                  ],
                ),
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
