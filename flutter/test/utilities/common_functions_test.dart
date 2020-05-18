import 'package:flutter_test/flutter_test.dart';
import 'package:sample/bloc/utilities/common_function.dart';

main() {
  group('time ago', () {
    test('未来の時間は「今」と表示される', () {
      final target = DateTime(DateTime.now().year + 1);
      expect(CommonFunction.timeAgo(target), CommonFunction.nowLabel);
    });
    test('１分以内は「今」と表示される', () {
      final target = DateTime.now().subtract(Duration(seconds: 10));
      expect(CommonFunction.timeAgo(target), CommonFunction.nowLabel);
    });
    test('12分前は「12分前」と表示される', () {
      final differenceInMinute = 12;
      final target =
          DateTime.now().subtract(Duration(minutes: differenceInMinute));
      expect(CommonFunction.timeAgo(target),
          '$differenceInMinute${CommonFunction.minuteLabel}');
    });
    test('7時間前は「7時間前」と表示される', () {
      final differenceInHour = 7;
      final target = DateTime.now().subtract(Duration(hours: differenceInHour));
      expect(CommonFunction.timeAgo(target),
          '$differenceInHour${CommonFunction.hourLabel}');
    });
  });
}
