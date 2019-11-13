
class DateUtils {

  static const int minutesPerYear = 525600;

  static Future<Duration> calculateTimeLeftToLiveDuration(DateTime dateOfBirth, int estimatedAge) async {
    Duration lifeDuration = Duration(minutes: estimatedAge * minutesPerYear);
    Duration alreadyLivedDuration = DateTime.now().difference(dateOfBirth);

    return Duration(
        minutes: lifeDuration.inMinutes - alreadyLivedDuration.inMinutes);
  }

}