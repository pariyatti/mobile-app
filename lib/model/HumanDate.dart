
class HumanDate {
  final DateTime date;
  HumanDate(this.date);

  String toString() {
    var humanDate = "${dayOfWeek(date)} ${date.day} ${month(date)}";
    if (date.year == DateTime.now().year) {
      return humanDate;
    }
    return "$humanDate, ${date.year}";
  }

  String dayOfWeek(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "monday";
      case 2:
        return "tuesday";
      case 3:
        return "wednesday";
      case 4:
        return "thursday";
      case 5:
        return "friday";
      case 6:
        return "saturday";
      case 7:
        return "sunday";
    }
    return "";
  }

  String month(DateTime date) {
    String m = "";
    switch (date.month) {
      case 1:
        m = "january";
        break;
      case 2:
        m = "february";
        break;
      case 3:
        m = "march";
        break;
      case 4:
        m = "april";
        break;
      case 5:
        m = "may";
        break;
      case 6:
        m = "june";
        break;
      case 7:
        m = "july";
        break;
      case 8:
        m = "august";
        break;
      case 9:
        m = "september";
        break;
      case 10:
        m = "october";
        break;
      case 11:
        m = "november";
        break;
      case 12:
        m = "december";
        break;
    }
    return m;
  }
}