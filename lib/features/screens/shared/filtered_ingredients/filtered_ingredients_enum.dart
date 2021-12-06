enum FilteredIngredientsEnum {
  CATEGORY,
  INGREDIENTS,
  TEXT,
}

extension FilteredIngredientsExtension on FilteredIngredientsEnum {
  String getTopBarName([String? complement]) {
    switch (this) {
      case FilteredIngredientsEnum.CATEGORY:
        return 'Resultado $complement';
      case FilteredIngredientsEnum.INGREDIENTS:
        return 'Resultado ingredientes';
      default:
        return '';
    }
  }
}
