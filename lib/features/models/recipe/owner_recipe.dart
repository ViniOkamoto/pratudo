class RecipeOwner {
  final String? id;
  final String name;

  RecipeOwner({
    required this.id,
    required this.name,
  });

  static RecipeOwner fromJson(Map<String, dynamic> json) => RecipeOwner(
        id: json['_id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
