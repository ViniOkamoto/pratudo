class RecipeQueryParams {
  final List<String> difficulties;
  final List<String> ingredients;
  final List<String> categories;
  final String name;
  final String portions;

  RecipeQueryParams({
    this.difficulties = const [],
    this.ingredients = const [],
    this.categories = const [],
    this.name = '',
    this.portions = '',
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.difficulties.isNotEmpty) data['difficulties'] = this.difficulties;
    if (this.ingredients.isNotEmpty) data['ingredients'] = this.ingredients;
    if (this.categories.isNotEmpty) data['categories'] = this.categories;
    if (this.portions.isNotEmpty) data['serves'] = this.portions;
    if (this.name.isNotEmpty) data['name'] = this.name;
    print(data);
    return data;
  }
}
