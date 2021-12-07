enum SearchTypeEnum {
  CATEGORY,
  INGREDIENTS,
  TEXT,
  ALL,
}

extension FilteredIngredientsExtension on SearchTypeEnum {
  String getTopBarName([String? complement]) {
    switch (this) {
      case SearchTypeEnum.CATEGORY:
        return 'Resultado $complement';
      case SearchTypeEnum.INGREDIENTS:
        return 'Resultado ingredientes';
      default:
        return '';
    }
  }
}
