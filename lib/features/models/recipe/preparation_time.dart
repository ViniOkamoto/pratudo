class PreparationTime {
  int value;
  String unit;

  PreparationTime({
    required this.value,
    required this.unit,
  });

  static PreparationTime fromJson(Map<String, dynamic> json) => PreparationTime(
        value: json['value'],
        unit: json['unit'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }

  String convertTimeToString({isLongText = false}) {
    int value = this.value;
    int hours = value ~/ 60;
    int minutes = value % 60;
    String timeToString = '';
    if (hours > 0) {
      if (isLongText) {
        timeToString = '$hours horas ';
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
