import 'package:flutter/material.dart';
import 'package:apod_app/models/picture.dart';

class DetailScreen extends StatelessWidget {
  final Picture picture;

  DetailScreen({required this.picture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(picture.title),
        backgroundColor: Color(0xFF000080),
      ),
      backgroundColor: Colors.black, // Definir o fundo preto
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(picture.hdUrl),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                color: Colors.blue.shade800,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Data: ${picture.date}', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                color: Colors.blue.shade900,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Descrição: ${picture.explanation}', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: 10),
            if (picture.copyright != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.blue.shade900,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Direitos autorais: ${picture.copyright}', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}