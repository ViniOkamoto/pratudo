class RecipeQueryParams {
  final List<String>? difficulties;
  final List<String>? ingredients;
  final List<String>? categories;
  final String? name;
  final String? portions;

  RecipeQueryParams({
    this.difficulties,
    this.ingredients,
    this.categories,
    this.name,
    this.portions,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.difficulties?.isNotEmpty ?? false)
      data['difficulties'] = this.difficulties;
    if (this.ingredients?.isNotEmpty ?? false)
      data['ingredients'] = this.ingredients;
    if (this.categories?.isNotEmpty ?? false)
      data['categories'] = this.categories;
    if (this.portions?.isNotEmpty ?? false) data['serves'] = this.portions;
    if (this.name?.isNotEmpty ?? false) data['name'] = this.name;

    return data;
  }
}
