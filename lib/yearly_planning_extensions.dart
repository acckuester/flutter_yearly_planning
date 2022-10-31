extension YearlyPlanningDateExtensions on DateTime {
  int daysInMonth() {
    final Map<int, int> monthLength = <int, int>{
      1: 31,
      2: isLeapYear() ? 29 : 28,
      3: 31,
      4: 30,
      5: 31,
      6: 30,
      7: 31,
      8: 31,
      9: 30,
      10: 31,
      11: 30,
      12: 31,
    };

    return monthLength[month] ?? 0;
  }

  bool isLeapYear() {
    bool leapYear = false;

    final bool leap = (year % 100 == 0) && (year % 400 != 0);
    if (leap == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }

  DateTime date() {
    return DateTime(year, month, day);
  }

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}