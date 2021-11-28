import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/unit_model.dart';
import 'package:pratudo/features/screens/create_recipe/form_section_store.dart';
import 'package:pratudo/features/widgets/base_modal.dart';

class UnitDropdown extends StatelessWidget {
  final List<UnitModel> unitList;
  final FormSectionStore formSectionStore;
  final int sectionIndex;
  final int ingredientIndex;

  const UnitDropdown({
    required this.unitList,
    required this.formSectionStore,
    required this.sectionIndex,
    required this.ingredientIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableFieldWithModal(
      modalItems: unitList,
      formSectionStore: formSectionStore,
      sectionIndex: sectionIndex,
      ingredientIndex: ingredientIndex,
    );
  }
}

class SelectableFieldWithModal extends StatelessWidget {
  final List<UnitModel> modalItems;
  final FormSectionStore formSectionStore;
  final int sectionIndex;
  final int ingredientIndex;

  const SelectableFieldWithModal({
    required this.modalItems,
    required this.formSectionStore,
    required this.sectionIndex,
    required this.ingredientIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          await showDialog(
            context: context,
            builder: (context) {
              return _OptionsModal(
                modalItems: modalItems,
                formSectionStore: formSectionStore,
                sectionIndex: sectionIndex,
                ingredientIndex: ingredientIndex,
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.only(
            left: SizeConverter.relativeWidth(12),
            right: SizeConverter.relativeWidth(10),
            top: SizeConverter.relativeWidth(8),
            bottom: SizeConverter.relativeWidth(8),
          ),
          decoration: BoxDecoration(
            color: AppColors.lightestGrayColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _catchUnitSelected()?.abbreviation ?? 'un',
                style: AppTypo.p3(
                  color: _catchUnitSelected() != null ? AppColors.darkestColor : AppColors.lightGrayColor,
                ),
              ),
              Icon(
                LineAwesomeIcons.angle_down,
                color: AppColors.highlightColor,
                size: SizeConverter.fontSize(12),
              ),
            ],
          ),
        ),
      );
    });
  }

  UnitModel? _catchUnitSelected() {
    try {
      return modalItems.firstWhere(
        (element) =>
            element.key == formSectionStore.sections[sectionIndex].ingredients[ingredientIndex].portion!.unitOfMeasure,
      );
    } catch (e) {
      return null;
    }
  }
}

class _OptionsModal extends StatelessWidget {
  final List<UnitModel> modalItems;
  final FormSectionStore formSectionStore;
  final int sectionIndex;
  final int ingredientIndex;

  const _OptionsModal({
    required this.modalItems,
    required this.formSectionStore,
    required this.sectionIndex,
    required this.ingredientIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BaseModal(
      body: Expanded(
        child: Scrollbar(
          isAlwaysShown: true,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              UnitModel unit = modalItems[index];
              return Observer(
                builder: (context) {
                  return RadioItemWidget<String>(
                    groupValue:
                        formSectionStore.sections[sectionIndex].ingredients[ingredientIndex].portion!.unitOfMeasure,
                    onChanged: (value) => formSectionStore.setIngredientUnit(value, sectionIndex, ingredientIndex),
                    value: unit.key,
                    text: '${unit.translate} (${unit.abbreviation})',
                  );
                },
              );
            },
            itemCount: modalItems.length,
          ),
        ),
      ),
      title: "Unidades de medida",
    );
  }
}

class RadioItemWidget<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String text;

  const RadioItemWidget({
    required this.groupValue,
    required this.onChanged,
    required this.value,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Expanded(
          child: Text(
            text,
            style: AppTypo.p2(color: AppColors.darkerColor),
          ),
        ),
      ],
    );
  }
}
