import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
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
  List<TextEditingController> ingredientNameControllers = [];
  List<Map<String, dynamic>> ingredientNameErrors = [];
  List<TextEditingController> quantityControllers = [];
  List<Map<String, dynamic>> ingredientQuantityErrors = [];

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
      ),
    );
  }

  @action
  removeSection(int index) {
    sections.removeAt(index);
    sectionNameErrors.removeAt(index);
    sectionNameControllers.removeAt(index);
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
    Map<String, dynamic> baseError = {"error": null};

    ingredientNameControllers.add(TextEditingController());
    ingredientQuantityErrors.add(baseError);
    ingredientNameErrors.add(baseError);
    quantityControllers.add(TextEditingController());
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
    ingredientNameErrors[ingredientIndex]['error'] = _validatorIfIsANullOrEmptyValue(
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
    ingredientNameErrors[ingredientIndex]['error'] = _validatorIfIsANullOrEmptyValue(
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
    ingredientNameControllers.removeAt(ingredientIndex);
    quantityControllers.removeAt(ingredientIndex);
  }
}
