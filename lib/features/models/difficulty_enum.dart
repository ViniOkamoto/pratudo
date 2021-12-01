enum DifficultyEnum {
  EASY,
  MEDIUM,
  HARD,
}

List<DifficultyEnum> difficultyList = [
  DifficultyEnum.EASY,
  DifficultyEnum.MEDIUM,
  DifficultyEnum.HARD,
];

Map<String, String> parseStringToEnum = {
  "EASY": DifficultyEnum.EASY.label,
  "MEDIUM": DifficultyEnum.MEDIUM.label,
  "HARD": DifficultyEnum.HARD.label,
};

extension DifficultyEnumExtension on DifficultyEnum {
  String get label {
    switch (this) {
      case DifficultyEnum.EASY:
        return 'Fácil';
      case DifficultyEnum.MEDIUM:
        return 'Média';
      case DifficultyEnum.HARD:
        return 'Difícil';
    }
  }

  String get key {
    switch (this) {
      case DifficultyEnum.EASY:
        return 'EASY';
      case DifficultyEnum.MEDIUM:
        return 'MEDIUM';
      case DifficultyEnum.HARD:
        return 'HARD';
    }
  }
}
