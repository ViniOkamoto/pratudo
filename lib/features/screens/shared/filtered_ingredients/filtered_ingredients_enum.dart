enum FilteredIngredientsEnum {
  CATEGORY,
  INGREDIENTS,
  TEXT,
}

extension FilteredIngredientsExtension on FilteredIngredientsEnum {
  String getTopBarName([String? complement]) {
    switch (this) {
      case FilteredIngredientsEnum.CATEGORY:
        print(complement);
        return 'Resultado $complement';
      case FilteredIngredientsEnum.INGREDIENTS:
        return 'Resultado ingredients';
      default:
        return '';
    }
  }
}
