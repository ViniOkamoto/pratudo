enum TimeEnum {
  HOURS,
  MINUTES,
  SECONDS,
}

extension TimeEnumExtension on TimeEnum {
  String get parseToString {
    switch (this) {
      case TimeEnum.HOURS:
        return 'HOURS';
      case TimeEnum.MINUTES:
        return 'MINUTES';
      case TimeEnum.SECONDS:
        return 'SECONDS';
      default:
        return 'NULL';
    }
  }

  String get parseToStringFront {
    switch (this) {
      case TimeEnum.HOURS:
        return 'Horas';
      case TimeEnum.MINUTES:
        return 'Minutos';
      case TimeEnum.SECONDS:
        return 'Segundos';
      default:
        return 'NULL';
    }
  }

  String get shortTimeString {
    switch (this) {
      case TimeEnum.HOURS:
        return 'hrs';
      case TimeEnum.MINUTES:
        return 'min';
      case TimeEnum.SECONDS:
        return 'seg';
      default:
        return 'NULL';
    }
  }
}

TimeEnum? parseStringToEnum(String enumString) {
  switch (enumString) {
    case 'HOURS':
      return TimeEnum.HOURS;
    case 'MINUTES':
      return TimeEnum.MINUTES;
    case 'SECONDS':
      return TimeEnum.SECONDS;
  }
}
