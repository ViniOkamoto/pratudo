class UnitHiveHelper {
  static const int type = 0;
  static const int keyUnitField = 0;
  static const int abbreviationUnitField = 1;
  static const int priorityTodoField = 2;
  static const int categoryTodoField = 3;
  static const int translateUnitField = 4;
  static const String boxName = "unitBox";
}

class RecipeHiveHelper {
  static const int type = 1;
  static const int idField = 0;
  static const int nameField = 1;
  static const int imagesField = 2;
  static const int difficultyField = 3;
  static const int servesField = 4;
  static const int chefTipsField = 5;
  static const int ownerField = 6;
  static const int ingredientsField = 7;
  static const int methodOfPreparationField = 8;
  static const int categoriesField = 9;
  static const int rateField = 10;
  static const int totalMethodOfPreparationField = 11;
  static const String boxName = "recipeBox";
}

class CategoryHiveHelper {
  static const int type = 2;
  static const int keyField = 0;
  static const int valueField = 1;
  static const int imageField = 2;
  static const String boxName = "categoryBox";
}
