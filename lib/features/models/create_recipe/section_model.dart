import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/create_recipe/recipe_creation_model.dart';
import 'package:pratudo/features/models/unit_model.dart';

class SectionModel {
  late final Key key;
  @observable
  late final String? sectionName;
  @observable
  late final UnitModel? unitModel;
  @observable
  late final int? time;
  @observable
  late final List<FormIngredientModel> ingredients;
  @observable
  late final List<StepByStepCreation> steps;

  SectionModel({
    required this.key,
    this.sectionName,
    this.unitModel,
    this.time,
    this.ingredients = const [],
    this.steps = const [],
  });

  SectionModel copyWith({
    String? sectionName,
    UnitModel? unitModel,
    int? time,
    List<FormIngredientModel>? ingredients,
    List<StepByStepCreation>? steps,
  }) {
    return SectionModel(
      key: key,
      sectionName: sectionName ?? this.sectionName,
      unitModel: unitModel ?? this.unitModel,
      time: time ?? this.time,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
    );
  }
}

class FormIngredientModel {
  @observable
  late final String? name;
  @observable
  late final Portion? portion;

  FormIngredientModel({
    this.name,
    this.portion,
  });

  FormIngredientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    portion = Portion.fromJson(json['portion']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['portion'] = portion!.toJson();
    return _data;
  }

  FormIngredientModel copyWith({
    String? name,
    Portion? portion,
  }) {
    return FormIngredientModel(
      name: name ?? this.name,
      portion: portion ?? this.portion,
    );
  }
}
