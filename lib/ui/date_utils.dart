import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

class DateUtils {
  static const String DATE_FORMAT = "dd/MM/yyyy";

  static int calculateMonthsFromNowUntil(Instant instant) {
    Period period = calculatePeriodFromNowUntil(instant);
    return period.years * 12 + period.months;
  }

  static Period calculatePeriodFromNowUntil(Instant instant) {
    return Period.differenceBetweenDates(
            LocalDate.today(), LocalDate.dateTime(instantToDateFormat(instant)));
  }

  static Time calculateTimeLeftToLive(DateTime dateOfBirth, int estimatedAge) {
    Time lifeTime = calculateLifeTime(dateOfBirth, estimatedAge);
    Time timeAlreadyLived =
        Instant.now().timeSince(Instant.dateTime(dateOfBirth));
    return lifeTime.subtract(timeAlreadyLived);
  }

  static Time calculateLifeTime(DateTime dateOfBirth, int estimatedAge) {
    Instant dateOfDeathInstant =
        Instant.dateTime(addYearsToDateTime(dateOfBirth, estimatedAge));
    return Instant.dateTime(dateOfBirth).timeUntil(dateOfDeathInstant);
  }

  static Instant calculateDateOfDeath(Time timeLeftToLive) {
    return Instant.now().add(timeLeftToLive);
  }

  static int calculateLivedPercentage(Time timeLeftToLive, Time lifeTime) {
    return ((1.0 -
                timeLeftToLive.inMilliseconds.toDouble() /
                    lifeTime.inMilliseconds.toDouble()) *
            100)
        .round();
  }

  static DateTime addYearsToDateTime(DateTime dateOfBirth, int estimatedAge) {
    // Very hacky, because of bad API (can't add years to DateTime)
    return DateFormat(DATE_FORMAT).parse(
        "${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year + estimatedAge}");
  }

  static DateTime instantToDateFormat(Instant instant) =>
      DateFormat(DATE_FORMAT).parse(instant.toString(DATE_FORMAT));
}
