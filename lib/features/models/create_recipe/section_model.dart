import 'package:flutter/cupertino.dart';
import 'package:pratudo/features/models/recipe/recipe_creation_model.dart';
import 'package:pratudo/features/models/unit_model.dart';

class SectionModel {
  late final Key key;
  late final String? sectionName;
  late final UnitModel? unitModel;
  late final int? time;
  late final List<Ingredient?> ingredients;
  late final List<StepByStep?> steps;

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
    List<Ingredient?>? ingredients,
    List<StepByStep?>? steps,
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
