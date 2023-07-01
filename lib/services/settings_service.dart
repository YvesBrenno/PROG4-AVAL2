import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<int> getPictureCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('pictureCount') ?? 10;
  }

  Future<void> setPictureCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('pictureCount', count);
  }
}