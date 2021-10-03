class BadgesModel {
  // List<Null> owned;
  int possibleBadges;
  int count;

  BadgesModel({
    // required this.owned,
    required this.possibleBadges,
    required this.count,
  });

  static BadgesModel fromJson(Map<String, dynamic> json) => BadgesModel(
        possibleBadges: json['possibleBadges'],
        count: json['count'],
      );
}
