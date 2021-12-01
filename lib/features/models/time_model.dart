class TimeModel {
  TimeModel({
    required this.unit,
    required this.value,
  });
  late final String unit;
  late final int value;

  TimeModel.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unit'] = unit;
    _data['value'] = value;
    return _data;
  }

  String convertTimeToString({isLongText = false}) {
    int value = this.value;
    int hours = value ~/ 60;
    int minutes = value % 60;
    String timeToString = '';
    if (hours > 0) {
      if (isLongText) {
        timeToString = '$hours horas';
      } else {
        timeToString = '${hours}h ';
      }
    }
    if (minutes > 0) {
      if (isLongText) {
        timeToString = '$timeToString$minutes minutos';
      } else {
        timeToString = '$timeToString${minutes}m';
      }
    }
    return timeToString;
  }
}
