import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

Future<void> main() async {
  runApp(PdfView(Uint8List(0)));
}

class PdfView extends StatelessWidget {
  PdfView(this.bytes, {super.key});

  final Uint8List bytes;

  WidgetsToImageController imageController = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Ejercicios'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_outlined)),
        ),
        body: PdfPreview(
          loadingWidget: const CircularProgressIndicator(color: Colors.black),
          build: (format) => _generatePdf(format, 'Ejercicios', bytes),
          actionBarTheme: const PdfActionBarTheme(
              backgroundColor: Color.fromARGB(255, 0, 0, 0)),
          canChangePageFormat: false,
          canDebug: false,
          canChangeOrientation: false,
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, String title, Uint8List bytes) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    // Genera la imagen TEX, asegurándote de manejar el caso cuando la lista esté vacía

    final pageWidth = format.availableWidth;
    final pageHeight = format.availableHeight;

    print('Width: $pageWidth, Height: $pageHeight');

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Expanded(
            child: getImage(bytes),
          );
        },
        margin: const pw.EdgeInsets.all(0),
      ),
    );

    return pdf.save();
  }
}

pw.Image getImage(Uint8List bytes) {
  return pw.Image(pw.MemoryImage(bytes));
}
