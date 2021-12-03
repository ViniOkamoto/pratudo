import 'package:hive/hive.dart';
import 'package:pratudo/features/models/recipe/portion_model.dart';

part 'items_model.g.dart';

@HiveType(typeId: 5)
class ItemsModel {
  @HiveField(0)
  late final String name;
  @HiveField(1)
  late final PortionModel portion;

  ItemsModel({
    required this.name,
    required this.portion,
  });

  ItemsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    portion = PortionModel.fromJson(json['portion']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['portion'] = portion.toJson();
    return _data;
  }

  ItemsModel copyWith({
    String? name,
    PortionModel? portion,
  }) {
    return ItemsModel(
      name: name ?? this.name,
      portion: portion ?? this.portion,
    );
  }
}
