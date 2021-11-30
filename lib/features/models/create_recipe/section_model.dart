import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/enums/time_enum.dart';
import 'package:pratudo/core/utils/enums/validate_enum.dart';
import 'package:pratudo/features/models/recipe/portion_model.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';

class SectionModel {
  late final Key key;
  @observable
  late final String? sectionName;
  @observable
  late final String? unit;
  @observable
  late final int time;
  @observable
  late final List<FormIngredientModel> ingredients;
  @observable
  late final List<StepByStepCreation> steps;

  SectionModel({
    required this.key,
    this.sectionName,
    this.time = 0,
    this.ingredients = const [],
    this.steps = const [],
  }) : this.unit = TimeEnum.MINUTES.parseToString;

  //Section base validators
  Map<String, ValidateEnum> get validateTime => time > 0
      ? {}
      : {'Tempo da seção': ValidateEnum.FIELD_LESS_THAN_OR_EQUAL_0};

  Map<String, ValidateEnum> get validateSection =>
      sectionName != null && sectionName!.isNotEmpty
          ? {}
          : {'Nome da seção': ValidateEnum.FIELD_EMPTY};

  // Ingredient validators
  Map<String, ValidateEnum> get validateIfHaveAnyIngredient =>
      ingredients.isNotEmpty
          ? {}
          : {'Ingrediente da seção': ValidateEnum.INGREDIENT_EMPTY};

  Map<String, ValidateEnum> get validateIfHaveAnyIngredientWithoutName =>
      ingredients.any((element) =>
              element.name == null ||
              (element.name != null && element.name!.isEmpty))
          ? {'Nome do ingrediente': ValidateEnum.FIELD_EMPTY}
          : {};

  Map<String, ValidateEnum> get validateIfHaveAnyIngredientWithoutPortion =>
      ingredients.any((element) => element.portion == null)
          ? {'Porção do ingrediente': ValidateEnum.FIELD_EMPTY}
          : {};

  Map<String, ValidateEnum>
      get validateIfHaveAnyIngredientWithoutPortionQuantity => ingredients.any(
              (element) =>
                  (element.portion != null && element.portion!.value <= 0))
          ? {
              'Quantidade do ingrediente':
                  ValidateEnum.FIELD_LESS_THAN_OR_EQUAL_0
            }
          : {};

  Map<String, ValidateEnum> get validateIfHaveAnyIngredientWithoutPortionUnit =>
      ingredients.any((element) => (element.portion!.unitOfMeasure == null ||
              element.portion!.unitOfMeasure != null &&
                  element.portion!.unitOfMeasure!.isEmpty))
          ? {'Unidade do ingrediente': ValidateEnum.FIELD_LESS_THAN_OR_EQUAL_0}
          : {};

  // Step Validators
  Map<String, ValidateEnum> get validateIfHaveAnyStep =>
      steps.isNotEmpty ? {} : {'Passo da seção': ValidateEnum.STEP_EMPTY};

  Map<String, ValidateEnum> get validateIfHaveAnyStepWithoutDescription =>
      steps.any((element) =>
              element.description == null ||
              element.description != null && element.description!.isEmpty)
          ? {'Descrição do passo': ValidateEnum.FIELD_EMPTY}
          : {};

  Map<String, Map<String, ValidateEnum>> validateSectionField(sectionIndex) {
    Map<String, ValidateEnum> errors = {};

    errors.addAll(validateSection);
    errors.addAll(validateTime);
    if (validateIfHaveAnyIngredient.isNotEmpty) {
      errors.addAll(validateIfHaveAnyIngredient);
    } else {
      errors.addAll(validateIfHaveAnyIngredientWithoutName);
      if (validateIfHaveAnyIngredientWithoutPortion.isNotEmpty) {
        errors.addAll(validateIfHaveAnyIngredientWithoutPortion);
      } else {
        errors.addAll(validateIfHaveAnyIngredientWithoutPortionQuantity);
        errors.addAll(validateIfHaveAnyIngredientWithoutPortionUnit);
      }
    }

    if (validateIfHaveAnyStep != {}) {
      errors.addAll(validateIfHaveAnyStep);
    } else {
      errors.addAll(validateIfHaveAnyStepWithoutDescription);
    }
    if (errors.isNotEmpty) {
      return {'${sectionIndex + 1}': errors};
    }
    return {};
  }

  SectionModel copyWith({
    String? sectionName,
    int? time,
    List<FormIngredientModel>? ingredients,
    List<StepByStepCreation>? steps,
  }) {
    return SectionModel(
      key: key,
      sectionName: sectionName ?? this.sectionName,
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
  late final PortionModel? portion;

  FormIngredientModel({
    this.name,
    this.portion,
  });

  FormIngredientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    portion = PortionModel.fromJson(json['portion']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['portion'] = portion!.toJson();
    return _data;
  }

  FormIngredientModel copyWith({
    String? name,
    PortionModel? portion,
  }) {
    return FormIngredientModel(
      name: name ?? this.name,
      portion: portion ?? this.portion,
    );
  }
}
