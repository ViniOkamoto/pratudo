import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/create_recipe/section_model.dart';
import 'package:pratudo/features/screens/create_recipe/form_section_store.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/recipe_section.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/unit_dropdown.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({
    Key? key,
    required RecipeHelpersStore recipeHelpersStore,
    required FormSectionStore formSectionStore,
    required this.onTapAdd,
    required this.onTapDelete,
    required this.ingredients,
    required this.sectionIndex,
    required this.ingredientNameControllers,
    required this.quantityControllers,
    required this.onChangedIngredientName,
    required this.onChangedIngredientQuantity,
  })  : _recipeHelpersStore = recipeHelpersStore,
        _formSectionStore = formSectionStore,
        super(key: key);

  final RecipeHelpersStore _recipeHelpersStore;
  final FormSectionStore _formSectionStore;
  final VoidCallback onTapAdd;
  final Function(int, int) onTapDelete;
  final List<FormIngredientModel> ingredients;
  final int sectionIndex;
  final List<TextEditingController> ingredientNameControllers;
  final List<TextEditingController> quantityControllers;
  final Function(String, int, int) onChangedIngredientName;
  final Function(String, int, int) onChangedIngredientQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Ingredientes",
                style: AppTypo.p3(color: AppColors.darkestColor),
              ),
              Spacing(height: 16),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: AppTextField(
                              hintText: "Farinha",
                              fieldTextStyle: AppTypo.p3,
                              textEditingController: ingredientNameControllers[index],
                              onChanged: (value) => onChangedIngredientName(value, sectionIndex, index),
                              verticalPadding: 8,
                            ),
                          ),
                          Spacing(width: 8),
                          Expanded(
                            flex: 3,
                            child: AppTextField(
                              fieldTextStyle: AppTypo.p3,
                              hintText: "1,0",
                              textEditingController: quantityControllers[index],
                              keyBoardType: TextInputType.number,
                              onChanged: (value) => onChangedIngredientQuantity(value, sectionIndex, index),
                              verticalPadding: 8,
                            ),
                          ),
                          Spacing(width: 8),
                          Expanded(
                            flex: 3,
                            child: UnitDropdown(
                              formSectionStore: _formSectionStore,
                              sectionIndex: sectionIndex,
                              ingredientIndex: index,
                              unitList: _recipeHelpersStore.units,
                            ),
                          ),
                          Spacing(width: 8),
                          GestureDetector(
                            onTap: () => onTapDelete(sectionIndex, index),
                            child: Icon(
                              LineAwesomeIcons.alternate_trash,
                              size: SizeConverter.fontSize(24),
                              color: AppColors.lightGrayColor,
                            ),
                          ),
                        ],
                      ),
                      Spacing(height: 16),
                    ],
                  );
                },
              ),
              AddOption(
                onTap: onTapAdd,
                label: "Adicionar Ingrediente",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
