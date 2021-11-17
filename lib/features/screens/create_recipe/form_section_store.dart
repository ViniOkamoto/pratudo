import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/create_recipe/section_model.dart';

part 'form_section_store.g.dart';

class FormSectionStore = _FormSectionStoreBase with _$FormSectionStore;

abstract class _FormSectionStoreBase with Store {
  @observable
  ObservableList<SectionModel> sections = ObservableList();

  List<TextEditingController> sectionNameControllers = [];
  List<Map<String, dynamic>> sectionNameErrors = [];

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

  String? _validatorIfIsANullOrEmptyValue(String? value, String fieldName) {
    if (value != null && value.isEmpty) {
      return "$fieldName não pode ser vazio";
    }
    return null;
  }
}
