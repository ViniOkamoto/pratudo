class UserInformationModel {
  final String name;
  final int level;
  final String title;

  UserInformationModel({
    required this.name,
    required this.level,
    required this.title,
  });

  static UserInformationModel fromJson(Map<String, dynamic> json) =>
      UserInformationModel(
        name: json['name'],
        level: json['level'],
        title: json['title'],
      );
}
