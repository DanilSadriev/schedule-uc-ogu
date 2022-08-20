class TimeUtils {
  String timeInterval(String startTime, String endTime) {
    int start = int.parse(startTime.substring(0, 2)) * 60 +
        int.parse(startTime.substring(3));
    int end = int.parse(endTime.substring(0, 2)) * 60 +
        int.parse(endTime.substring(3));
    return '${end - start}';
  }

  bool finishedLecture(String time, DateTime date, bool completedPastDays) {
    DateTime dateNow = DateTime.now();
    // DateTime timeNow = DateTime(dateNow.year, dateNow.month, dateNow.day);

    // log('$timeNow\n$date\n${date.compareTo(timeNow).isNegative},  $completedPastDays');

    // if (date
    //         .compareTo(DateTime(dateNow.year, dateNow.month, dateNow.day))
    //         .isNegative &&
    //     completedPastDays) {
    //   log(true.toString());
    //   return true;
    // } else {
    //   log(false.toString());
    int hourNow = dateNow.hour;
    int minuteNow = dateNow.minute;

    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(3));

    if (date.year == dateNow.year &&
        date.month == dateNow.month &&
        date.day == dateNow.day) {
      if (hour <= hourNow || (hour == hourNow && minute <= minuteNow)) {
        return true;
      } else if (hour > hourNow || (hour == hourNow && minute > minuteNow)) {
        return false;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  // }
}
