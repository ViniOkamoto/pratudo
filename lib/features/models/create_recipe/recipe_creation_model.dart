import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

class RecipeCreationModel {
  RecipeCreationModel({
    required this.name,
    required this.images,
    required this.difficulty,
    required this.serves,
    required this.creationDate,
    required this.chefTips,
    required this.ingredients,
    required this.methodOfPreparation,
    required this.tags,
    required this.categories,
  });
  late final String name;
  late final List<String> images;
  late final String difficulty;
  late final int serves;
  late final String creationDate;
  late final String chefTips;
  late final List<Ingredient> ingredients;
  late final MethodOfPreparation methodOfPreparation;
  late final List<String> tags;
  late final List<String> categories;

  RecipeCreationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    images = List.castFrom<dynamic, String>(json['images']);
    difficulty = json['difficulty'];
    serves = json['serves'];
    creationDate = json['creationDate'];
    chefTips = json['chefTips'];
    ingredients = List.from(json['ingredients']).map((e) => Ingredient.fromJson(e)).toList();
    methodOfPreparation = MethodOfPreparation.fromJson(json['methodOfPreparation']);
    tags = List.castFrom<dynamic, String>(json['tags']);
    categories = List.castFrom<dynamic, String>(json['categories']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['images'] = images;
    _data['difficulty'] = difficulty;
    _data['serves'] = serves;
    _data['creationDate'] = creationDate;
    _data['chefTips'] = chefTips;
    _data['ingredients'] = ingredients.map((e) => e.toJson()).toList();
    _data['methodOfPreparation'] = methodOfPreparation.toJson();
    _data['tags'] = tags;
    _data['categories'] = categories;
    return _data;
  }
}

class Ingredient {
  Ingredient({
    this.step,
    this.items,
  });
  late final String? step;
  late final List<Items>? items;

  Ingredient.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['step'] = step;
    _data['items'] = items!.map((e) => e.toJson()).toList();
    return _data;
  }

  Ingredient copyWith({
    String? step,
    List<Items>? items,
  }) {
    return Ingredient(
      step: step ?? this.step,
      items: items ?? this.items,
    );
  }
}

class Items {
  late final String? name;
  late final Portion? portion;

  Items({
    required this.name,
    required this.portion,
  });

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    portion = Portion.fromJson(json['portion']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['portion'] = portion!.toJson();
    return _data;
  }

  Items copyWith({
    String? name,
    Portion? portion,
  }) {
    return Items(
      name: name ?? this.name,
      portion: portion ?? this.portion,
    );
  }
}

class Portion {
  Portion({
    this.value = 0,
    this.unitOfMeasure,
  });
  @observable
  late final double value;
  @observable
  late final String? unitOfMeasure;

  Portion.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unitOfMeasure = json['unitOfMeasure'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['unitOfMeasure'] = unitOfMeasure;
    return _data;
  }

  Portion copyWith({
    double? value,
    String? unitOfMeasure,
  }) {
    return Portion(
      value: value ?? this.value,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
    );
  }
}

class MethodOfPreparation {
  MethodOfPreparation({
    required this.steps,
  });
  late final List<Steps> steps;

  MethodOfPreparation.fromJson(Map<String, dynamic> json) {
    steps = List.from(json['steps']).map((e) => Steps.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['steps'] = steps.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Steps {
  Steps({
    required this.step,
    required this.items,
  });
  late final String step;
  late final List<StepByStepCreation> items;

  Steps.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    items = List.from(json['items']).map((e) => StepByStepCreation.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['step'] = step;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

enum StepEnum {
  DEFAULT,
  WITHTIME,
}

class StepByStepCreation {
  late final Key? key;
  late final String? description;
  StepByStepCreation({
    this.key,
    this.description,
  });

  StepByStepCreation.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['description'] = description;
    return _data;
  }

  StepByStepCreation copyWith({
    String? description,
  }) {
    return StepByStepCreation(
      key: key,
      description: description ?? this.description,
    );
  }
}

class StepByStepWithTimeCreation extends StepByStepCreation {
  late final Time? time;
  StepByStepWithTimeCreation({
    Key? key,
    String? description,
    this.time,
  }) : super(description: description, key: key);

  factory StepByStepWithTimeCreation.fromJson(Map<String, dynamic> json) => StepByStepWithTimeCreation(
        time: Time.fromJson(json['time']),
        description: json['value'],
      );

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['time'] = time!.toJson();
    return data;
  }

  StepByStepWithTimeCreation copyWith({
    String? description,
    Time? time,
  }) {
    return StepByStepWithTimeCreation(
      key: key,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }
}

class Time {
  Time({
    required this.unit,
    required this.value,
  });
  late final String unit;
  late final int value;

  Time.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unit'] = unit;
    _data['value'] = value;
    return _data;
  }
}
