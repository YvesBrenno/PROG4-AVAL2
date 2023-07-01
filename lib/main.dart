import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Seu Título',
      theme: ThemeData(
        primaryColor: Color(0xFF000080),
      ),
      home: HomeScreen(),
    );
  }
}