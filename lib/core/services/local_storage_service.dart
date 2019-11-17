import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  static const String KEY_DATE = "date";
  static const String KEY_AGE = "age";

  SharedPreferences _prefsInstance;

  Future<SharedPreferences> _getPrefs() async {
    if (_prefsInstance == null) {
      _prefsInstance = await SharedPreferences.getInstance();
    }
    return _prefsInstance;
  }

  Future saveDataToPreferences(DateTime dateOfBirth, int estimatedAge) async {
    SharedPreferences prefs = await _getPrefs();
    prefs.setInt(KEY_DATE, dateOfBirth.millisecondsSinceEpoch);
    prefs.setInt(KEY_AGE, estimatedAge);
  }

  Future<DateTime> getDateOfBirth() async {
    SharedPreferences prefs = await _getPrefs();
    int dateOfBirth = prefs.getInt(KEY_DATE);
    if (dateOfBirth == null) {
      return null;
    } else {
      return DateTime.fromMillisecondsSinceEpoch(dateOfBirth);
    }
  }

  Future<int> getEstimatedAge() async {
    SharedPreferences prefs = await _getPrefs();
    return prefs.getInt(KEY_AGE);
  }

}
