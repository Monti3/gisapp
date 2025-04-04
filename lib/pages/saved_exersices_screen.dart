import 'package:flutter/material.dart';
import 'preview_pdf.dart';
import '../services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedExersicesScreen extends StatefulWidget {
  const SavedExersicesScreen({super.key});

  @override
  State<SavedExersicesScreen> createState() => _SavedExersicesScreenState();
}

class _SavedExersicesScreenState extends State<SavedExersicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ejercicios guardados',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
          future: getExcersices(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              // filtra los ejercicios por el userId actual
              String currentUserId = getUId();
              final filteredExcersices = snapshot.data!.where((exercise) {
                return exercise['userId'] == currentUserId;
              }).toList();

              if (filteredExcersices.isEmpty) {
                return Center(child: Text('No tenés ejercicios guardados.'));
              }

              return ListView.builder(
                itemCount: filteredExcersices.length,
                itemBuilder: (context, index) {
                  final info = filteredExcersices[index]['excersice'];
                  final int studentQuantity =
                      filteredExcersices[index]['studentQuantity'];
                  final int excersicePerStudent =
                      filteredExcersices[index]['excersicesPerStudent'];
                  final String topic = filteredExcersices[index]['topic'];

                  List<String> strlist = info.cast<String>();
                  return SavedExcersciceCard(
                      strlist, studentQuantity, excersicePerStudent, topic);
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error al cargar los ejercicios.'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}

class SavedExcersciceCard extends StatelessWidget {
  const SavedExcersciceCard(this.savedExcersice, this.studentQuantity,
      this.excersicePerStudent, this.topic,
      {super.key});

  final savedExcersice;
  final int studentQuantity;
  final int excersicePerStudent;
  final String topic;

  @override
  Widget build(BuildContext context) {
     return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewPdf(studentQuantity,
                  excersicePerStudent, savedExcersice, '', true)),
        );
      },
      child: SizedBox(
        height: 60,
        child: Card(
          child: Center(
              child: Column(
                children: [
                  Text(
                              'Ejercicios guardados de $topic',
                              style: TextStyle(color: Colors.black),
                            ),
                ],
              )),
        ),
      ),
    );

  }
}
