import 'package:flutter/material.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_by_step_model.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/ingredient_check_list_view.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/secondary_app_bar.dart';

class SteByStepPage extends StatefulWidget {
  final StepByStepModel stepByStepModel;

  const SteByStepPage({
    Key? key,
    required this.stepByStepModel,
  }) : super(key: key);

  @override
  _SteByStepPageState createState() => _SteByStepPageState();
}

class _SteByStepPageState extends State<SteByStepPage> {
  final PageController pageController = PageController();
  final RecipeHelpersStore recipeHelpersStore =
      serviceLocator<RecipeHelpersStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        text: widget.stepByStepModel.name,
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        'Vamos ao preparo!',
                        style: AppTypo.h2(color: AppColors.darkestColor),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      IngredientCheckListView(
                        ingredients: widget.stepByStepModel.ingredients,
                        unitsOfMeasure: recipeHelpersStore.units,
                      ),
                      Text('teste 2'),
                    ],
                    controller: pageController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConverter.relativeWidth(16),
                    vertical: SizeConverter.relativeHeight(32),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text('teste'),
                    ],
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
