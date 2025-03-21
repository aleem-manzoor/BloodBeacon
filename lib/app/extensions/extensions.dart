import 'package:flutter/cupertino.dart';

extension SizeBox on num {
  SizedBox get height => SizedBox(
        height: toDouble(),
      );
  SizedBox get width => SizedBox(
        width: toDouble(),
      );
}

/// Extension to calculate week of the year for DateTime
extension WeekOfYear on DateTime {
  int get weekOfYear {
    final firstDayOfYear = DateTime(year, 1, 1);
    final daysSinceFirstDay =
        difference(firstDayOfYear).inDays + firstDayOfYear.weekday;
    return (daysSinceFirstDay / 7).ceil();
  }
}
