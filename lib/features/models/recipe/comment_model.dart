class CommentModel {
  CommentModel({
    required this.id,
    required this.owner,
    required this.content,
    required this.creationDate,
    required this.replies,
  });
  late final String id;
  late final String owner;
  late final String content;
  late final String creationDate;
  late final List<RepliesModel> replies;

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'];
    content = json['content'];
    creationDate = json['creationDate'];
    replies = List.from(json['replies'])
        .map((e) => RepliesModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['owner'] = owner;
    _data['content'] = content;
    _data['creationDate'] = creationDate;
    _data['replies'] = replies.map((e) => e.toJson()).toList();
    return _data;
  }
}

class RepliesModel {
  RepliesModel({
    required this.id,
    required this.owner,
    required this.content,
    required this.creationDate,
  });
  late final String id;
  late final String owner;
  late final String content;
  late final String creationDate;

  RepliesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'];
    content = json['content'];
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['owner'] = owner;
    _data['content'] = content;
    _data['creationDate'] = creationDate;
    return _data;
  }
}
