import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';

part 'recipe_form_store.g.dart';

class RecipeFormStore = _RecipeFormStoreBase with _$RecipeFormStore;

abstract class _RecipeFormStoreBase with Store {
  final TextEditingController ingredientField = TextEditingController();
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController chefTipController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @observable
  String? image;

  @action
  setImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      List<int> fileInByte = File(pickedFile!.path).readAsBytesSync();
      String fileInBase64 = base64Encode(fileInByte);
      image = fileInBase64;
    } catch (e) {
      //Skip Interaction
    }
  }

  @action
  removeImage() async {
    image = null;
  }

  @observable
  String? recipeName;

  @observable
  String? errorRecipeName;

  @observable
  @action
  setRecipeName(String value) {
    recipeName = value;
    errorRecipeName = _validatorIfIsANullOrEmptyValue(recipeName, "Nome da receita");
  }

  @observable
  String? description;

  @action
  setDescription(String value) {
    description = value;
  }

  @observable
  ObservableList<RecipeHelperModel> categories = ObservableList();

  @action
  setCategory(List<Object?> value) {
    List<RecipeHelperModel> recipeList = [];
    value.forEach((element) {
      recipeList.add(element as RecipeHelperModel);
    });
    this.categories.clear();
    categories.addAll(recipeList);
  }

  @action
  unsetCategory(Object? value) {
    categories.removeWhere((element) => element.key == (value as RecipeHelperModel).key);
  }

  String? _validatorIfIsANullOrEmptyValue(String? value, String fieldName) {
    if (value != null && value.isEmpty) {
      return "$fieldName não pode ser vazio";
    }
    return null;
  }

  @observable
  DifficultyEnum? difficulty;

  @action
  setDifficulty(DifficultyEnum? value) {
    difficulty = value;
  }

  @observable
  int portion = 1;

  @action
  void onTapMore() {
    portion++;
  }

  @action
  void onTapLess() {
    if (portion > 1) {
      portion--;
    }
  }

  @observable
  String? chefTip;

  @action
  setChefTip(String value) {
    chefTip = value;
  }
}
