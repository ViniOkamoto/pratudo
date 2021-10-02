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
}
