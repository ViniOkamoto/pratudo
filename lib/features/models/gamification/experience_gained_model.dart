class ExperienceGainedModel {
  ExperienceGainedModel({
    required this.gainedExperience,
    required this.reason,
  });
  late final int gainedExperience;
  late final String reason;

  ExperienceGainedModel.fromJson(Map<String, dynamic> json) {
    gainedExperience = json['gainedExperience'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['gainedExperience'] = gainedExperience;
    _data['reason'] = reason;
    return _data;
  }
}
