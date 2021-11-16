class UnitModel {
  final String key;
  final String abbreviation;
  final String translate;

  UnitModel({
    required this.key,
    required this.abbreviation,
    required this.translate,
  });

  static UnitModel fromJson(Map<String, dynamic> json) => UnitModel(
        key: json['key'],
        abbreviation: json['abbreviation'],
        translate: json['translate'],
      );

  static List<UnitModel> fromJsonList(List<dynamic> json) {
    return json.map((i) => fromJson(i)).toList();
  }
}
