import 'package:flutter/material.dart';

class NumberDropdown extends StatefulWidget {
  final int initialValue; // Valor inicial pasado al widget
  final ValueChanged<int> onChanged; // Callback para manejar el cambio
  final String title; 
  const NumberDropdown(
      {Key? key,
      required this.initialValue,
      required this.onChanged,
      required this.title})
      : super(key: key);

  @override
  _NumberDropdownState createState() => _NumberDropdownState();
}

class _NumberDropdownState extends State<NumberDropdown> {
  late int _selectedNumber; // Almacena el número seleccionado

  @override
  void initState() {
    super.initState();
    _selectedNumber = widget.initialValue; // Inicializa el número seleccionado
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          // Muestra el número seleccionado
          DropdownButton<int>(
            underline: Container(),
            
            value: _selectedNumber,
            hint: const Text('Selecciona un número'),
            items: List.generate(
                    7, (index) => index) // Genera una lista de 0 a 6
                .map((number) => DropdownMenuItem<int>(
                      value: number,
                      child: Center(child: Text(number
                          .toString(), textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none),)), // Muestra el número como texto
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedNumber = value ??
                    _selectedNumber; // Actualiza el número seleccionado
              });
              if (value != null) {
                widget.onChanged(
                    value); // Llama al callback con el nuevo valor
              }
            },
            isExpanded: true, // Opción para expandir el dropdown
          ),
        ],
      ),
    );
  }
}
