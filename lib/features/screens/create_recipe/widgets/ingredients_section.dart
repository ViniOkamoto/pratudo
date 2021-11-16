import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/unit_model.dart';
import 'package:pratudo/features/screens/create_recipe/create_recipe_page.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/unit_dropdown.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({
    Key? key,
    required RecipeHelpersStore recipeHelpersStore,
  })  : _recipeHelpersStore = recipeHelpersStore,
        super(key: key);

  final RecipeHelpersStore _recipeHelpersStore;

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
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: AppTextField(
                      hintText: "Farinha",
                      fieldTextStyle: AppTypo.p3,
                      textEditingController: TextEditingController(),
                      onChanged: (onChanged) {},
                      verticalPadding: 8,
                    ),
                  ),
                  Spacing(width: 8),
                  Expanded(
                    flex: 3,
                    child: AppTextField(
                      fieldTextStyle: AppTypo.p3,
                      hintText: "1,0",
                      textEditingController: TextEditingController(),
                      onChanged: (onChanged) {},
                      verticalPadding: 8,
                    ),
                  ),
                  Spacing(width: 8),
                  Expanded(
                    flex: 3,
                    child: UnitDropdown(
                      onChanged: (value) {},
                      value: UnitModel(
                        abbreviation: "un",
                        key: "UNIT",
                        translate: "Unidade",
                      ),
                      unitList: _recipeHelpersStore.units,
                    ),
                  ),
                  Spacing(width: 8),
                  Icon(
                    LineAwesomeIcons.alternate_trash,
                    size: SizeConverter.fontSize(24),
                    color: AppColors.lightGrayColor,
                  ),
                ],
              ),
              Spacing(height: 16),
              AddOption(
                onTap: () {},
                label: "Adiciona Ingrediente",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
