import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/create_recipe/section_model.dart';
import 'package:pratudo/features/models/recipe/recipe_creation_model.dart';

part 'form_section_store.g.dart';

class FormSectionStore = _FormSectionStoreBase with _$FormSectionStore;

abstract class _FormSectionStoreBase with Store {
  @observable
  ObservableList<SectionModel> sections = ObservableList();

  @action
  addSection() {
    sections.add(
      SectionModel(
        key: UniqueKey(),
      ),
    );
  }

  @action
  removeSection(int index) {
    sections.removeAt(index);
  }

  addIngredients(Ingredient ingredient) {}
}
