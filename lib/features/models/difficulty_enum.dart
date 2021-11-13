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
}
