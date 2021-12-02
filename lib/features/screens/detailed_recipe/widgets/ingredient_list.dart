import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/ingredient_model.dart';
import 'package:pratudo/features/models/unit_model.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/ingredient_items_list.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_detailed_sections_title.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class IngredientsListSection extends StatelessWidget {
  const IngredientsListSection({
    Key? key,
    required this.ingredients,
    required this.unitsOfMeasure,
  }) : super(key: key);
  final List<IngredientModel> ingredients;
  final List<UnitModel> unitsOfMeasure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipeDetailedSectionsTitle(
          icon: LineAwesomeIcons.blender,
          text: 'Ingredientes',
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(8),
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            IngredientModel ingredient = ingredients[index];
            return IngredientItems(
              stepName: ingredient.step!,
              items: ingredient.items ?? [],
              unitsOfMeasure: unitsOfMeasure,
            );
          },
          separatorBuilder: (context, index) => Spacing(height: 8),
          itemCount: ingredients.length,
        ),
      ],
    );
  }
}
