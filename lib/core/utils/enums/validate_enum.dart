enum ValidateEnum {
  FIELD_EMPTY,
  SECTIONS_EMPTY,
  FIELD_LESS_THAN_OR_EQUAL_0,
  INGREDIENT_EMPTY,
  STEP_EMPTY,
}

extension ExtesionValidateEnum on ValidateEnum {
  String get validateToString {
    switch (this) {
      case ValidateEnum.FIELD_EMPTY:
        return 'O seguintes campos não podem ser vazios:\n';
      case ValidateEnum.FIELD_LESS_THAN_OR_EQUAL_0:
        return 'O seguintes campos não podem ser menores ou igual a zero:\n';
      case ValidateEnum.INGREDIENT_EMPTY:
        return 'A seção não possui ingredientes\n';
      case ValidateEnum.STEP_EMPTY:
        return 'A seção não possui passos\n';
      case ValidateEnum.SECTIONS_EMPTY:
        return 'A receita não possui seções';
    }
  }
}
