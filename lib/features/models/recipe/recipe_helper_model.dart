class RecipeHelperModel {
  String key;
  String value;
  String? image64;

  RecipeHelperModel({required this.key, required this.value, this.image64});

  static RecipeHelperModel fromJson(Map<String, dynamic> json) => RecipeHelperModel(
        key: json['key'],
        value: json['value'],
        image64: json['image'],
      );

  static List<RecipeHelperModel> fromJsonList(List<dynamic> json) {
    return json.map((i) => fromJson(i)).toList();
  }
}
