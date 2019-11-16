import 'package:shared_preferences/shared_preferences.dart';

class Data {
  static Future<SharedPreferences> _getPrefs() async =>
      SharedPreferences.getInstance();

  static Future saveDataToPreferences(
      DateTime dateOfBirth, int estimatedAge) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setInt("date", dateOfBirth.millisecondsSinceEpoch);
    prefs.setInt("age", estimatedAge);
  }

  static Future<DateTime> getDateOfBirth() async {
    int dateOfBirth = (await _getPrefs()).getInt("date");
    if (dateOfBirth == null) {
      return null;
    } else {
      return DateTime.fromMillisecondsSinceEpoch(dateOfBirth);
    }
  }

  static Future<int> getEstimatedAge() async =>
      (await _getPrefs()).getInt("age");
}
