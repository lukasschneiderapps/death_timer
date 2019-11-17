import 'package:death_timer/utils/date_utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:test/test.dart';

void main() {
  test('Test 10 years from now', () async {
    Duration duration = await DateUtils.calculateTimeLeftToLive(DateTime.now(), 10);
    expect(duration.inMinutes, 10 * DateUtils.minutesPerYear);
  });

  test('Test 10 years ago and age = 20', () async {
    Duration duration = await DateUtils.calculateTimeLeftToLive(Jiffy(DateTime.now()).subtract(years: 10), 20);
    expect(duration.inMinutes / DateUtils.minutesPerYear, 10);
  });
}
