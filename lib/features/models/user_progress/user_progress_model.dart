import 'package:pratudo/features/models/user_progress/badges_model.dart';
import 'package:pratudo/features/models/user_progress/experience_model.dart';

class UserProgressModel {
  int level;
  ExperienceModel experience;
  String title;
  BadgesModel badges;

  UserProgressModel({
    required this.level,
    required this.experience,
    required this.title,
    required this.badges,
  });

  static UserProgressModel fromJson(Map<String, dynamic> json) => UserProgressModel(
        level: json['level'],
        experience: ExperienceModel.fromJson(json['experience']),
        title: json['title'],
        badges: BadgesModel.fromJson(json['badges']),
      );
}
