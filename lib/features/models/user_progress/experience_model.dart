class ExperienceModel {
  int current;
  int from;
  int toNextLevel;
  double percentage;

  ExperienceModel({
    required this.current,
    required this.from,
    required this.toNextLevel,
    required this.percentage,
  });

  static ExperienceModel fromJson(Map<String, dynamic> json) => ExperienceModel(
        current: json['current'],
        from: json['from'],
        toNextLevel: json['toNextLevel'],
        percentage: (json['percentage'] as int).toDouble(),
      );
}
