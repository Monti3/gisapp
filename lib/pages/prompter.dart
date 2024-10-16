import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../pages/preview_pdf.dart';
import '../keys.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/widgets.dart' as pw;

List topicPrompt = <List>[
  ['Integrals', 'Integrales'],
  ['derivatives', 'Derivadas'],
  [
    'math powers and exponents rules. Use numbers, not variables. have in account divisions, multiplicartions, etc.Only the operation, without the results. Try to be vertical.',
    'Exponentes'
  ],
  [
    'combined operations. Two exercises per line as maximum',
    'Cálculos Combinados'
  ],
  ['Right triangle resolution', 'Triángulos rectos'],
  ['Sine and cosine theorems', 'Teoremas seno y coseno'],
  ['Angle measurement systems', 'Medición de ángulos'],
  ['Trig identities and equations. give a starting expression and a final expression', 'Ident. trigonométricas'],
  ['Systems of equations', 'Sistemas de ecuaciones'],
  ['Quadratic equations and functions', 'Ecuaciones cuadráticas'],
  ['Exponential and logarithmic equations', 'Ecuaciones exponenciales'],
  ['Operations with radicals', 'Radicales'],
  ['Rational exponent powers', 'Potencia racional'],
  ['Complex numbers concept', 'Números complejos'],
  ['Complex number operations', 'Operaciones complejos'],
  ['Graphical representation of complex numbers', 'Rep. gráfica complejos'],
  ['Polynomial concepts and operations', 'Polinomios'],
  [
    'Ruffini’s rule, remainder theorem, and factorization',
    'Ruffini y factorización'
  ],
  ['Rational equations', 'Ecuaciones racionales'],
  ['Limits and continuity, dont use tikzpicture', 'Límites y continuidad'],
  ['Derivatives definition', 'Derivadas: definición'],
  ['Integral by substitution', 'Integración por sustitución'],
  ['Fourier series and graphs', 'Series Fourier y gráficas'],
];

List<String> topicList = <String>[for (List i in topicPrompt) i[1]];

class Prompter extends StatefulWidget {
  const Prompter({super.key});

  @override
  State<Prompter> createState() => _PrompterState();
}

class _PrompterState extends State<Prompter> {
  WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();
  int quantity = 1;
  int studentsQuantity = 1;
  String responseText = r'\textbf{Cargando}'; // Mensaje inicial
  String topic = 'Integrals';
  String emphasis = '';
  List<String> texCodeList = [];
  List<WidgetsToImage> texImageList = [];
  Widget pdfButton = Container();
  late List<Uint8List> imageCodeList = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  List<Widget> mathTexList = [];
  List<Uint8List> bytesList = [];
  late Uint8List? bytes;
  late pw.Widget mathPdfWIdget;
  int excersicesPerAlumn = 0;
  Widget promptResultView = const Text(
    'Seleccioná un tema',
    style: TextStyle(fontWeight: FontWeight.bold),
  );

  @override
  void initState() {
    super.initState();
    widgetsToImageController = WidgetsToImageController();
  }

  Future<void> prompt() async {
    int excersiceQuantity = excersicesPerAlumn * studentsQuantity;
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: geminikey,
      );
      dynamic content = [
        Content.text(
            'you are a math teacher assistant: create a TeX expression for different $topic exercises.${studentsQuantity} students, $excersicesPerAlumn excersises for each one.'
            'One expression per excersice, separete each expression with a Ñ like making a list. Only the tex code for the expression. Without the begin and end. Do not use \\[ nor. generate exactly ${quantity * studentsQuantity} excersices. no more nor less. Just expressions. Dont put a Ñ if theres not. cant use \$ in math mode. just math expressions. dont enumerate.one expression per excersice. between two Ñs, one expression. do emphasis in $emphasis. One expression per element. Exactly ${studentsQuantity * excersicesPerAlumn} excercices, you are in math mode '
            'make exactly ${excersiceQuantity} excersices no more no less'),
            
      ];
      excersiceQuantity = studentsQuantity * excersicesPerAlumn;
      final response;
      response = await model.generateContent(content);

      setState(() async {
        responseText = response.text ?? r'\text{Respuesta vacía}';
        mathTexList = [];

        final int limit = 2 * studentsQuantity * excersicesPerAlumn;

        texCodeList = responseText.split('Ñ');
        print(texCodeList);
        print('texcode list: ${texCodeList.length}');
        for (String i in texCodeList) {
          print('LLL: S${mathTexList.length}');

          if (mathTexList.length < limit) {
            mathTexList.add((Math.tex(i)));
            mathTexList.add(const SizedBox(height: 3));
          } else {
            break;
          }
        }
        if (texCodeList.length != limit / 2) {
          promptResultView = Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Intentelo de Nuevo'),
              ],
            ),
          );
        } else {
          promptResultView = Column(
            children: mathTexList +
                [
                  const SizedBox(
                    height: 8,
                  )
                ],
          );
        }

        print(texCodeList);
      });
    } catch (e) {
      setState(() {
        responseText = r'\text{Error al obtener respuesta}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final ExportDelegate exportDelegate = ExportDelegate();

    return Scaffold(
      
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Generá tus ejercicios',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: ExportFrame(
                          frameId: 'frameId',
                          exportDelegate: exportDelegate,
                          child: promptResultView,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    emphasis = value;
                  }
                });
              },
              decoration: InputDecoration(
                labelText: 'Detalle',
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
              cursorColor: Colors.black),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownMenu<String>(
                label: const Text('Contenido'),
                enableFilter: false,
                onSelected: (value) {
                  setState(() {
                    topic = topicPrompt[topicList.indexOf(value.toString())][0];
                    print(topic);
                  });
                },
                dropdownMenuEntries:
                    topicList.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry(value: value, label: value);
                }).toList(),
              ),
              pdfButton,
              IconButton(
                icon: const SizedBox(
                  child: Icon(Icons.send),
                ),
                onPressed: () {
                  setState(() {
                    pdfButton = IconButton(
                      onPressed: () async {
                        final widget =
                            await exportDelegate.exportToPdfWidget('frameId');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviewPdf(quantity,
                                  studentsQuantity, texCodeList, topic, false)),
                        );
                      },
                      icon: const Icon(Icons.picture_as_pdf),
                    );
                    promptResultView = const CircularProgressIndicator(
                      color: Colors.black,
                    );
                  });
                  prompt();
                },
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Flexible(
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _controller2,
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty &&
                            int.tryParse(value) != null &&
                            int.parse(value) > 0) {
                          excersicesPerAlumn = int.parse(value);
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Cantidad de Temas',
                      labelStyle: TextStyle(color: Colors.black),
                      border: const OutlineInputBorder(), // Borde normal
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width:
                                2.0), // Color y ancho del borde al estar enfocado
                      ),
                      focusColor: Colors
                          .black, // Esto solo afecta el color de la barra de enfoque en el label
                    ),
                    cursorColor: Colors.black),
              ),
              Flexible(
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _controller3,
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty &&
                            int.tryParse(value) != null &&
                            int.parse(value) > 0) {
                          studentsQuantity = int.parse(value);
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Ejercicios por tema',
                      labelStyle: TextStyle(color: Colors.black),
                      border: const OutlineInputBorder(), // Borde normal
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width:
                                2.0), // Color y ancho del borde al estar enfocado
                      ),
                      focusColor: Colors
                          .black, // Esto solo afecta el color de la barra de enfoque en el label
                    ),
                    cursorColor: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 6.4),
        ],
      ),
    );
  }
}

class MathWidget extends StatelessWidget {
  const MathWidget(this.code, {super.key});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Math.tex(code);
  }
}
