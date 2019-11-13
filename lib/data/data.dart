import 'package:shared_preferences/shared_preferences.dart';

class Data {
  static Future<SharedPreferences> _getPrefs() async =>
      SharedPreferences.getInstance();

  static Future saveDataToPreferences(DateTime dateOfBirth, int estimatedAge) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setInt("date", dateOfBirth.millisecondsSinceEpoch);
    prefs.setInt("age", estimatedAge);
  }

  static Future<DateTime> getDateOfBirth() async =>
      DateTime.fromMillisecondsSinceEpoch(
          (await _getPrefs()).getInt("date") ?? 0);

  static Future<int> getEstimatedAge() async => (await _getPrefs()).getInt("age") ?? 0;

}
