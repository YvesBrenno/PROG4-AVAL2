import 'package:flutter/material.dart';
import 'package:apod_app/models/picture.dart';
import 'package:apod_app/services/apod_service.dart';
import 'package:apod_app/screens/detail_screen.dart';
import 'package:apod_app/screens/settings_screen.dart';
import 'package:apod_app/screens/about_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Picture>> futurePictures; // Lista futura de imagens
  int pictureCount = 10; // Define o número inicial de imagens para buscar

  @override
  void initState() {
    super.initState();
    loadPictureCount(); // Carrega o número de imagens salvas nas preferências
    futurePictures = fetchPictures(); // Busca as imagens
  }

  Future<List<Picture>> fetchPictures() async { // Método que busca as imagens
    return await ApodService().fetchPictures(pictureCount);
  }

  loadPictureCount() async { // Método que carrega o número de imagens salvas
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pictureCount = (prefs.getInt('pictureCount') ?? 10);
    });
  }

  @override
  Widget build(BuildContext context) { // Método que constrói a interface do usuário
    return Scaffold(
      appBar: AppBar(
        title: Text('Picture of The Day'),
        backgroundColor: Color(0xFF000080), // Define a cor do AppBar
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.info),
            onPressed: () { // Navega para a tela "Sobre" quando pressionado
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
          // Ícone de configurações
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async { // Navega para a tela de configurações quando pressionado e, ao retornar, recarrega as imagens
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
              setState(() {
                loadPictureCount();
                futurePictures = fetchPictures();
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.black, // Definir o fundo preto
      body: FutureBuilder<List<Picture>>( // Constrói a lista de imagens
        future: futurePictures,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Mostra um indicador de progresso enquanto aguarda as imagens
          } else if (snapshot.hasError) {
            return Center( // Mostra uma mensagem de erro se houver uma falha
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error_outline, color: Colors.red, size: 60),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Erro: ${snapshot.error}'),
                  )
                ],
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async { // Permite que a lista de imagens seja atualizada quando arrasta pra baixo
                setState(() {
                  futurePictures = fetchPictures();
                });
              },
              child: ListView.builder( // Cria a lista de imagens
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data![index].title,
                      style: TextStyle(color: Colors.white), // Define a cor do texto como branca
                    ),
                    subtitle: Text(
                      snapshot.data![index].date,
                      style: TextStyle(color: Colors.white), // Define a cor do texto como branca
                    ),
                    leading: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white), // Contorno nas imagens
                      ),
                      child: Image.network(snapshot.data![index].url),
                    ),
                    onTap: () { // Navega pra a tela de detalhes ao tocar em uma imagem
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            picture: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}