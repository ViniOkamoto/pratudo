import 'package:hive/hive.dart';
import 'package:pratudo/features/models/recipe/items_model.dart';

part 'ingredient_model.g.dart';

@HiveType(typeId: 4)
class IngredientModel {
  @HiveField(0)
  late final String? step;
  @HiveField(1)
  late final List<ItemsModel>? items;

  IngredientModel({
    this.step,
    this.items,
  });

  IngredientModel.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    items =
        List.from(json['items']).map((e) => ItemsModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['step'] = step;
    _data['items'] = items!.map((e) => e.toJson()).toList();
    return _data;
  }

  IngredientModel copyWith({
    String? step,
    List<ItemsModel>? items,
  }) {
    return IngredientModel(
      step: step ?? this.step,
      items: items ?? this.items,
    );
  }
}
