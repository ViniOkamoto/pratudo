import 'package:flutter/material.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/drop_down_item.dart';
import 'package:pratudo/features/widgets/app_dropdown_field.dart';

class DifficultyDropdown extends StatelessWidget {
  final List<DifficultyEnum> difficultyList;
  final Function(DifficultyEnum?) onChanged;
  final DifficultyEnum? value;

  const DifficultyDropdown({
    required this.difficultyList,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return FormDropdownField<DifficultyEnum>(
      hintText: "Selecione a dificuldade da receita",
      labelText: "Dificuldade da receita",
      onChanged: (value) => onChanged(value),
      value: value,
      items: difficultyList
          .map(
            (difficulty) => DropdownMenuItem(
              value: difficulty,
              child: DropdownItem(
                label: difficulty.label,
              ),
            ),
          )
          .toList(),
    );
  }
}
