import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_math_fork/flutter_math.dart';


class PromptService {
  Future<void> prompt({
    required int excersicesPerAlumn,
    required int studentsQuantity,
    required String topic,
    required String emphasis,
    required int quantity,
    required String geminikey,
    required Function(List<Widget> mathTexList) onSuccess,
    required Function(String errorText) onError,
  }) async {
    int excersiceQuantity = excersicesPerAlumn * studentsQuantity;
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: geminikey,
      );
      
      // Preparando el contenido
      dynamic content = [
        Content.text(
          'you are a math teacher assistant: create a TeX expression for different $topic exercises.'
          '${studentsQuantity} students, $excersicesPerAlumn excersises for each one.'
          'One expression per excersice, separete each expression with a Ñ like making a list. '
          'Only the tex code for the expression. Without the begin and end. Do not use \\[ nor. '
          'generate exactly ${quantity * studentsQuantity} excersices. no more nor less. '
          'Just expressions. Dont put a Ñ if theres not. cant use \$ in math mode. '
          'just math expressions. dont enumerate. one expression per excersice. '
          'between two Ñs, one expression. do emphasis in $emphasis. '
          'One expression per element. Exactly ${studentsQuantity * excersicesPerAlumn} excercices, you are in math mode ',
        ),
      ];
      
      // Llamada al modelo generativo
      final response = await model.generateContent(content);
      
      // Procesar la respuesta
      String responseText = response.text ?? r'\text{Respuesta vacía}';
      List<String> texCodeList = responseText.split('Ñ');
      List<Widget> mathTexList = [];

      final int limit = 2 * studentsQuantity * excersicesPerAlumn;

      for (String tex in texCodeList) {
        if (mathTexList.length < limit) {
          mathTexList.add(Math.tex(tex)); // Asegúrate de importar el paquete correcto
          mathTexList.add(const SizedBox(height: 3));
        } else {
          break;
        }
      }

      if (texCodeList.length != limit / 2) {
        onError('Intetalo de Nuevo');
      } else {
        onSuccess(mathTexList);
      }

    } catch (e) {
      onError(r'\text{Error al obtener respuesta}');
    }
  }
}
