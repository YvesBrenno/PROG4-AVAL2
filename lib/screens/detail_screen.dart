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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(picture.hdUrl),
            SizedBox(height: 10),
            Text('Data: ${picture.date}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Descrição: ${picture.explanation}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            if (picture.copyright != null)
              Text('Direitos autorais: ${picture.copyright}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}