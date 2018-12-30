abstract class DateTimeCustom {
  String create(String time, String type);
}

class DateTimeCustomImplementation implements DateTimeCustom {
  static DateTimeCustomImplementation _singleton =
      DateTimeCustomImplementation.internal();

  factory DateTimeCustomImplementation() {
    return _singleton;
  }

  DateTimeCustomImplementation.internal();

  static String DATE = 'DATE';
  static String TIME = 'TIME';
  static String DATEANDTIME = 'DATEANDTIME';

  String create(String datetime, String type) {
    if (type == DateTimeCustomImplementation.DATE) {
      return _createDate(datetime);
    } else if (type == DateTimeCustomImplementation.TIME) {
      return _createTime(datetime);
    }
    return '${_createDate(datetime)} ${_createTime(datetime)}';
  }

  String _createDate(String datetime) {
    DateTime _datetime = DateTime.parse(datetime).toLocal();
    return '${_datetime.year}-${_datetime.month}-${_datetime.day}';
  }

  String _createTime(String datetime) {
    DateTime _datetime = DateTime.parse(datetime).toLocal();
    return '${_datetime.hour}:${_datetime.minute}';
  }
}
