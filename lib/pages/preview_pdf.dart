import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/services/firestore_service.dart';
import '/pages/pdf_view.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

class PreviewPdf extends StatefulWidget {
  const PreviewPdf(this.studentQuantity, this.excersicesPerStudent,
      this.texList, this.topic, this.isSaved,
      {super.key});

  final List<String> texList;
  final int studentQuantity;
  final int excersicesPerStudent;
  final String topic;
  final bool isSaved;

  @override
  State<PreviewPdf> createState() => _PreviewPdfState();
}

class _PreviewPdfState extends State<PreviewPdf> {
  @override
  Widget build(BuildContext context) {
    WidgetsToImageController controller = WidgetsToImageController();
    Uint8List? bytes;
    bool alreadySaved = false;

    // Crear la lista de Math widgets con claves únicas
    List<Widget> mathList = [
      for (String i in widget.texList) Math.tex(i, key: UniqueKey())
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Vista Previa',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: WidgetsToImage(
          controller: controller,
          child: ExcersiceColumns(
              mathList, widget.excersicesPerStudent, widget.studentQuantity),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.black,
            child: Icon(Icons.add_task, color: Colors.white),
          ),
          SizedBox(width: 10),
          !(widget.isSaved)
              ? FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () async {
                    bytes = await controller.capture();
                    print('add bytes');
                    if (alreadySaved == false)
                    {await addExcersice(widget.texList, widget.studentQuantity,
                        widget.excersicesPerStudent, widget.topic);
                    Fluttertoast.showToast(
                        msg: 'Ejercicio guardado',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 14.0);}
                        alreadySaved = true; 
                  },
                  child: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                )
              : SizedBox(),
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () async {
              bytes = await controller.capture();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PdfView(bytes!)),
              );
            },
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class Excersice extends StatelessWidget {
  const Excersice(this.widgets, {super.key});
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Curso: ..................'),
          const Text('Nombre: .................'),
          const SizedBox(height: 3),
          Row(children: [
            SizedBox(
              width: 3,
            ),
            Column(children: [
              ...addSeparators(widgets, 3)
            ]), // colum para wrapearlo verticalmente
            SizedBox(
              width: 2,
            )
          ]), // row para que no se superponga con la linea de margen
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}

class ExcersiceColumns extends StatelessWidget {
  const ExcersiceColumns(
      this.maths, this.excersicesPerStudent, this.studentQuantity,
      {super.key});
  final List<Widget> maths;
  final int studentQuantity;
  final int excersicesPerStudent;

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> excersicesList = splitList(maths, excersicesPerStudent);
    List<Widget> excersiceList = [];

    // Iterar a través de los ejercicios y crear filas
    for (int i = 0; i < excersicesList.length; i += 3) {
      List<Widget> rowChildren = [];

      rowChildren.add(Excersice(excersicesList[i]));

      // Agregar el segundo Excersice si existe
      if (i + 1 < excersicesList.length) {
        rowChildren.add(Excersice(excersicesList[i + 1]));
      }
      if (i + 2 < excersicesList.length) {
        rowChildren.add(Excersice(excersicesList[i + 2]));
      }

      // Crear la fila
      excersiceList.add(Row(children: rowChildren));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: excersiceList,
    );
  }
}

List<List<T>> splitList<T>(List<T> list, int chunkSize) {
  List<List<T>> chunks = [];

  for (var i = 0; i < list.length; i += chunkSize) {
    int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
    chunks.add(list.sublist(i, end));
  }

  return chunks;
}

List<Widget> addSeparators(List<Widget> widgets, double space) {
  List<Widget> separatedWidgets = [];

  for (int i = 0; i < widgets.length; i++) {
    separatedWidgets.add(widgets[i]);
    if (i < widgets.length - 1) {
      separatedWidgets.add(SizedBox(height: space));
    }
  }

  print(separatedWidgets);
  return separatedWidgets;
}
