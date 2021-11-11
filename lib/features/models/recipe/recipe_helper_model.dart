class RecipeHelperModel {
  String key;
  String value;

  RecipeHelperModel({required this.key, required this.value});

  static RecipeHelperModel fromJson(Map<String, dynamic> json) => RecipeHelperModel(
        key: json['key'],
        value: json['value'],
      );

  static List<RecipeHelperModel> fromJsonList(List<dynamic> json) {
    return json.map((i) => fromJson(i)).toList();
  }
}
