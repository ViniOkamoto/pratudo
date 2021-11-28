import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/enums/time_enum.dart';
import 'package:pratudo/core/utils/enums/validate_enum.dart';
import 'package:pratudo/features/models/create_recipe/recipe_creation_model.dart';
import 'package:pratudo/features/models/create_recipe/section_model.dart';

part 'form_section_store.g.dart';

class FormSectionStore = _FormSectionStoreBase with _$FormSectionStore;

abstract class _FormSectionStoreBase with Store {
  List<SectionModel> sections = ObservableList();
  //Section controllers
  List<TextEditingController> sectionNameControllers = [];
  List<Map<String, dynamic>> sectionNameErrors = [];
  //Ingredient controllers
  Map<int, List<TextEditingController>> ingredientNameControllers = {};
  Map<int, List<Map<String, String?>>> ingredientNameErrors = {};
  Map<int, List<TextEditingController>> quantityControllers = {};
  Map<int, List<Map<String, String?>>> ingredientQuantityErrors = {};
  //Step controllers
  Map<int, List<TextEditingController>> stepDescriptionControllers = {};
  Map<int, List<Map<String, String?>>> stepErrors = {};

  String? _validatorIfIsANullOrEmptyValue(String? value, String fieldName) {
    if (value != null && value.isEmpty) {
      return "FIELD_NULL";
    }
    return null;
  }

  bool checkIfHaveASection() {
    return sections.isNotEmpty;
  }

  Map<String, Map<String, ValidateEnum>> _getValidation() {
    Map<String, Map<String, ValidateEnum>> errors = {};
    for (int i = 0; i < sections.length; i++) {
      SectionModel section = sections[i];
      if (errors.length < 2) {
        errors.addAll(section.validateSectionField(i));
      }
    }
    return errors;
  }

  String? getErrors() {
    final errors = _getValidation();
    if (errors.isNotEmpty) {
      String finalString = '';
      errors.forEach((key, value) {
        String section = 'Seção número $key:\n';
        List<String> fieldsEmpty = [];
        List<String> fieldsLessThanZero = [];

        value.forEach((key, value) {
          if (value == ValidateEnum.FIELD_EMPTY) {
            fieldsEmpty.add(key);
          }
          if (value == ValidateEnum.FIELD_LESS_THAN_OR_EQUAL_0) {
            fieldsLessThanZero.add(key);
          }
          if (value == ValidateEnum.INGREDIENT_EMPTY) {
            section += '${value.validateToString}';
          }
          if (value == ValidateEnum.STEP_EMPTY) {
            section += '${value.validateToString}';
          }
        });
        if (fieldsEmpty.isNotEmpty) {
          String fields = fieldsEmpty.toString().replaceAll('[', '').replaceAll(']', '');
          section += '${ValidateEnum.FIELD_EMPTY.validateToString + fields}\n';
        }
        if (fieldsLessThanZero.isNotEmpty) {
          String fields = fieldsLessThanZero.toString().replaceAll('[', '').replaceAll(']', '');
          section += '${ValidateEnum.FIELD_LESS_THAN_OR_EQUAL_0.validateToString + fields}\n';
        }
        finalString += '$section';
      });
      return finalString;
    }
    return null;
  }

  @action
  addSection() {
    Map<String, dynamic> baseError = {"error": null};
    sectionNameControllers.add(TextEditingController());
    sectionNameErrors.add(baseError);
    sections.add(
      SectionModel(
        key: UniqueKey(),
        time: 0,
      ),
    );
  }

  @action
  removeSection(int index) {
    if (sections.length > index + 1) {
      _reorderMaps(index);
    } else {
      _removeSection(index);
    }
  }

  _removeSection(index) {
    sections.removeAt(index);
    sectionNameErrors.removeAt(index);
    sectionNameControllers.removeAt(index);
    ingredientNameControllers.removeWhere((key, value) => key == index);
    ingredientNameErrors.removeWhere((key, value) => key == index);
    quantityControllers.removeWhere((key, value) => key == index);
    ingredientQuantityErrors.removeWhere((key, value) => key == index);
    stepDescriptionControllers.removeWhere((key, value) => key == index);
    stepErrors.removeWhere((key, value) => key == index);
  }

  _reorderMaps(int index) {
    int lastPosition = sections.length - 1;
    for (int i = index; i < lastPosition; i++) {
      int nextPosition = index + 1;
      sectionNameErrors.removeAt(index);
      sectionNameControllers.removeAt(index);
      ingredientNameErrors[index] = ingredientNameErrors[(nextPosition)] as List<Map<String, String?>>;
      ingredientNameErrors.remove(lastPosition);
      ingredientNameControllers[index] = ingredientNameControllers[(nextPosition)] as List<TextEditingController>;
      ingredientNameControllers.remove(lastPosition);
      quantityControllers[index] = quantityControllers[(nextPosition)] as List<TextEditingController>;
      quantityControllers.remove(lastPosition);
      ingredientQuantityErrors[index] = ingredientQuantityErrors[(nextPosition)] as List<Map<String, String?>>;
      ingredientQuantityErrors.remove(lastPosition);
      stepDescriptionControllers[index] = stepDescriptionControllers[(nextPosition)] as List<TextEditingController>;
      stepDescriptionControllers.remove(lastPosition);
      stepErrors[index] = stepErrors[(nextPosition)] as List<Map<String, String?>>;
      stepErrors.remove(lastPosition);
      sections.removeAt(index);
    }
  }

  @action
  setSectionName(String value, int sectionIndex) {
    SectionModel section = sections[sectionIndex];
    sections[sectionIndex] = section.copyWith(sectionName: value);
    sectionNameErrors[sectionIndex]['error'] = _validatorIfIsANullOrEmptyValue(
      value,
      "Título da seção",
    );
  }

  @action
  addIngredient(int sectionIndex) {
    Map<String, String?> baseError = {"error": null};

    ingredientNameControllers[sectionIndex] = [...?ingredientNameControllers[sectionIndex], TextEditingController()];
    ingredientQuantityErrors[sectionIndex] = [...?ingredientQuantityErrors[sectionIndex], baseError];
    ingredientNameErrors[sectionIndex] = [...?ingredientNameErrors[sectionIndex], baseError];
    quantityControllers[sectionIndex] = [...?quantityControllers[sectionIndex], TextEditingController()];
    SectionModel section = sections[sectionIndex];
    sections[sectionIndex] = section.copyWith(
      ingredients: [
        ...section.ingredients,
        FormIngredientModel(
          portion: Portion(),
        )
      ],
    );
  }

  @action
  setIngredientName(String value, int sectionIndex, int ingredientIndex) {
    SectionModel section = sections[sectionIndex];
    List<FormIngredientModel> ingredients = section.ingredients;
    FormIngredientModel ingredient = ingredients[ingredientIndex];
    ingredients[ingredientIndex] = ingredient.copyWith(name: value);
    sections[sectionIndex] = section.copyWith(ingredients: ingredients);
    ingredientNameErrors[sectionIndex]![ingredientIndex]['error'] = _validatorIfIsANullOrEmptyValue(
      value,
      "Nome do ingrediente",
    );
  }

  @action
  setIngredientQuantity(String value, int sectionIndex, int ingredientIndex) {
    SectionModel section = sections[sectionIndex];
    List<FormIngredientModel> ingredients = section.ingredients;
    FormIngredientModel ingredient = ingredients[ingredientIndex];
    if (value.contains(',')) {
      value.replaceFirst(",", ".");
      value.replaceAll(",", " ");
    }
    ingredients[ingredientIndex] = ingredient.copyWith(
      portion: ingredient.portion!.copyWith(
        value: double.parse(value.isEmpty ? '0' : value),
      ),
    );

    sections[sectionIndex] = section.copyWith(ingredients: ingredients);
    ingredientNameErrors[sectionIndex]![ingredientIndex]['error'] = _validatorIfIsANullOrEmptyValue(
      value,
      "Nome do ingrediente",
    );
  }

  @action
  setIngredientUnit(String? value, int sectionIndex, int ingredientIndex) {
    SectionModel section = sections[sectionIndex];
    List<FormIngredientModel> ingredients = section.ingredients;
    FormIngredientModel ingredient = ingredients[ingredientIndex];

    ingredients[ingredientIndex] = ingredient.copyWith(
      portion: ingredient.portion!.copyWith(
        unitOfMeasure: value,
      ),
    );
    sections[sectionIndex] = section.copyWith(ingredients: ingredients);
  }

  @action
  removeIngredient(int sectionIndex, int ingredientIndex) {
    SectionModel section = sections[sectionIndex];
    List<FormIngredientModel> ingredients = [...section.ingredients];
    ingredients.removeAt(ingredientIndex);
    sections[sectionIndex] = section.copyWith(ingredients: ingredients);
    ingredientNameControllers[sectionIndex]!.removeAt(ingredientIndex);
    quantityControllers[sectionIndex]!.removeAt(ingredientIndex);
  }

  @action
  addStep(int sectionIndex, StepEnum stepType) {
    Map<String, String?> baseError = {"error": null};
    stepDescriptionControllers[sectionIndex] = [...?stepDescriptionControllers[sectionIndex], TextEditingController()];
    stepErrors[sectionIndex] = [...?stepErrors[sectionIndex], baseError];
    SectionModel section = sections[sectionIndex];
    if (stepType == StepEnum.WITH_TIME) {
      sections[sectionIndex] = section.copyWith(
        steps: [
          ...section.steps,
          StepByStepWithTimeCreation(
            key: UniqueKey(),
          ),
        ],
      );
      return;
    }
    sections[sectionIndex] = section.copyWith(
      steps: [
        ...section.steps,
        StepByStepCreation(
          key: UniqueKey(),
        ),
      ],
    );
  }

  @action
  reorderStep(int sectionIndex, oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex = newIndex - 1;
    }
    SectionModel section = sections[sectionIndex];
    List<StepByStepCreation> steps = [...section.steps];

    final element = steps.removeAt(oldIndex);
    steps.insert(newIndex, element);
    sections[sectionIndex] = section.copyWith(
      steps: steps,
    );

    final controller = stepDescriptionControllers[sectionIndex]!.removeAt(oldIndex);
    stepDescriptionControllers[sectionIndex]!.insert(newIndex, controller);
  }

  @action
  setStepDescription(String value, int sectionIndex, int stepIndex) {
    SectionModel section = sections[sectionIndex];
    List<StepByStepCreation> steps = section.steps;
    StepByStepCreation step = steps[stepIndex];
    steps[stepIndex] = step.copyWith(description: value);
    sections[sectionIndex] = section.copyWith(steps: steps);
    stepErrors[sectionIndex]![stepIndex]['error'] = _validatorIfIsANullOrEmptyValue(
      value,
      "Descrição do passo",
    );
  }

  @action
  setStepTime(Duration value, int sectionIndex, int stepIndex) {
    SectionModel section = sections[sectionIndex];
    List<StepByStepCreation> steps = section.steps;
    StepByStepWithTimeCreation step = steps[stepIndex] as StepByStepWithTimeCreation;
    Time newTime = Time(
      value: value.inMinutes,
      unit: TimeEnum.MINUTES.parseToString,
    );
    steps[stepIndex] = step.copyWith(time: newTime);
    sections[sectionIndex] = section.copyWith(steps: steps);

    _calculateSectionTime(sectionIndex);
  }

  @action
  removeStep(int sectionIndex, int stepIndex) {
    SectionModel section = sections[sectionIndex];
    List<StepByStepCreation> steps = [...section.steps];
    steps.removeAt(stepIndex);
    sections[sectionIndex] = section.copyWith(steps: steps);
    stepDescriptionControllers[sectionIndex]!.removeAt(stepIndex);
    stepErrors[sectionIndex]!.removeAt(stepIndex);

    _calculateSectionTime(sectionIndex);
  }

  _calculateSectionTime(int index) {
    int value = 0;
    sections[index].steps.forEach(
      (element) {
        if (element is StepByStepWithTimeCreation) value += element.time!.value;
      },
    );
    sections[index] = sections[index].copyWith(time: value);
  }
}
