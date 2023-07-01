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
  late Future<List<Picture>> futurePictures;
  int pictureCount = 10;

  @override
  void initState() {
    super.initState();
    loadPictureCount();
    futurePictures = fetchPictures();
  }

  Future<List<Picture>> fetchPictures() async {
    return await ApodService().fetchPictures(pictureCount);
  }

  loadPictureCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pictureCount = (prefs.getInt('pictureCount') ?? 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Astronomy Picture of The Day'),
        backgroundColor: Color(0xFF000080), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
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
      body: FutureBuilder<List<Picture>>(
        future: futurePictures,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
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
              onRefresh: () async {
                setState(() {
                  futurePictures = fetchPictures();
                });
              },
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].date),
                    leading: Image.network(snapshot.data![index].url),
                    onTap: () {
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