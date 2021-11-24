import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/enums/time_enum.dart';
import 'package:pratudo/features/models/create_recipe/recipe_creation_model.dart';
import 'package:pratudo/features/models/create_recipe/section_model.dart';

part 'form_section_store.g.dart';

class FormSectionStore = _FormSectionStoreBase with _$FormSectionStore;

abstract class _FormSectionStoreBase with Store {
  @observable
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
      return "$fieldName não pode ser vazio";
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
        unit: TimeEnum.MINUTES.parseToString,
      ),
    );
  }

  @action
  removeSection(int index) {
    sections.removeAt(index);
    sectionNameErrors.removeAt(index);
    sectionNameControllers.removeAt(index);
    ingredientNameControllers.removeWhere((key, value) => key == index);
    quantityControllers.removeWhere((key, value) => key == index);
    ingredientNameErrors.removeWhere((key, value) => key == index);
    ingredientQuantityErrors.removeWhere((key, value) => key == index);
    stepDescriptionControllers.removeWhere((key, value) => key == index);
    stepErrors.removeWhere((key, value) => key == index);
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
    if (stepType == StepEnum.WITHTIME) {
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
