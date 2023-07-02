import 'package:flutter/material.dart'; // Importa o pacote Flutter Material Design
import 'screens/home_screen.dart'; // Importa o arquivo da tela inicial

void main() {
  runApp(MyApp()); // Roda o aplicativo
}

class MyApp extends StatelessWidget { // Classe que representa todo o aplicativo
  @override
  Widget build(BuildContext context) { // Cria a interface do usuário
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de debug.
      title: 'Astronomy Picture Of the Day', // Define o título do aplicativo
      theme: ThemeData( // Define o tema do aplicativo
        primaryColor: Color(0xFF000080), // Define a cor primária do tema
      ),
      home: HomeScreen(), // Define a primeira tela ao iniciar o aplicativo
    );
  }
}