import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apod_app/models/picture.dart';

class ApodService {
  final String apiKey = 'fjrf2f22XFsb6SuGhRmDuC6kog3QFoOiPW0GP20v';
  final String apiEndpoint = 'https://api.nasa.gov/planetary/apod';

  Future<List<Picture>> fetchPictures(int count) async {
    List<Picture> pictureList = [];
    DateTime today = DateTime.now();
    for (var i = 0; i < count; i++) {
      String dateString = formatDate(today.subtract(Duration(days: i)));
      String requestUrl = '$apiEndpoint?api_key=$apiKey&date=$dateString';

      final response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        pictureList.add(Picture.fromJson(json.decode(response.body)));
      } else {
        throw Exception('Erro ao carregar as imagens. Por favor, tente novamente.');
      }
    }
    return pictureList;
  }

  String formatDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }
}