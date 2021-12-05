import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/ingredient_model.dart';
import 'package:pratudo/features/models/recipe/items_model.dart';
import 'package:pratudo/features/models/unit_model.dart';
import 'package:pratudo/features/widgets/custom_text.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}

class IngredientCheckListView extends StatelessWidget {
  const IngredientCheckListView({
    Key? key,
    required this.ingredients,
    required this.unitsOfMeasure,
  }) : super(key: key);
  final List<IngredientModel> ingredients;
  final List<UnitModel> unitsOfMeasure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConverter.relativeWidth(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'Hora de conferir o que tem na sua cozinha',
                  textAlign: TextAlign.center,
                  style: AppTypo.h2(color: AppColors.darkestColor),
                ),
                Spacing(height: 16),
                CustomText(
                  text: 'Sinta-se a vontade para realizar um *checklist* '
                      'ou *pule para o próximo passo*.',
                  textAlign: TextAlign.center,
                  style: AppTypo.p3(color: AppColors.greyColor),
                  highlightTextColor: AppColors.darkColor,
                  fontWeight: FontWeight.w500,
                ),
                Spacing(height: 24),
                Text(
                  'Ingredientes',
                  style: AppTypo.h2(color: AppColors.highlightColor),
                ),
                Spacing(height: 8),
                Expanded(
                  child: Scrollbar(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        IngredientModel ingredientList = ingredients[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ingredientList.step!}:',
                              style: AppTypo.h3(color: AppColors.greyColor),
                            ),
                            _CheckboxList(
                              items: ingredientList.items!,
                              unitsOfMeasure: unitsOfMeasure,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Spacing(height: 16),
                      itemCount: ingredients.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckboxList extends StatefulWidget {
  const _CheckboxList({
    Key? key,
    required this.items,
    required this.unitsOfMeasure,
  }) : super(key: key);

  final List<ItemsModel> items;
  final List<UnitModel> unitsOfMeasure;

  @override
  State<_CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<_CheckboxList> {
  late final ingredients = widget.items.map((item) {
    UnitModel unit = widget.unitsOfMeasure
        .firstWhere((element) => element.key == item.portion.unitOfMeasure);
    return CheckBoxState(
      title: '*${item.portion.quantity} '
          '${unit.translate.toLowerCase()}'
          ' de* ${item.name}',
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ...ingredients.map(buildSingleCheckBox).toList(),
      ],
    );
  }

  Widget buildSingleCheckBox(CheckBoxState state) => CheckboxListTile(
        onChanged: (value) => setState(() {
          state.value = value!;
        }),
        dense: true,
        activeColor: AppColors.highlightColor,
        value: state.value,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        title: CustomText(
          text: state.title,
          style: AppTypo.p3(color: AppColors.darkColor),
          fontWeight: FontWeight.w500,
          highlightTextColor: AppColors.darkerColor,
        ),
      );
}
