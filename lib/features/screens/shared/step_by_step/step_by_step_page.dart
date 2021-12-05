import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_by_step_model.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_by_step_store.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/back_view.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/ingredient_check_list_view.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/next_view.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/step_view.dart';
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
  final RecipeHelpersStore recipeHelpersStore =
      serviceLocator<RecipeHelpersStore>();
  final StepByStepStore _store = serviceLocator<StepByStepStore>();
  late final List<Widget> pages;
  @override
  void initState() {
    List<Widget> steps = _loadSteps();
    pages = [
      IngredientCheckListView(
        ingredients: widget.stepByStepModel.ingredients,
        unitsOfMeasure: recipeHelpersStore.units,
      ),
      ...steps,
    ];
    super.initState();
  }

  List<Widget> _loadSteps() {
    List<Widget> steps = [];
    Map<String, int> stepsLength = {};
    widget.stepByStepModel.steps.forEach(
      (section) {
        steps = [
          ...steps,
          ...section.items
              .map((e) => StepView(step: e, sectionName: section.step))
              .toList(),
        ];
        stepsLength[section.step] = steps.length;
      },
    );
    _store.setStepLength(stepsLength);
    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: Observer(
          builder: (context) {
            return Text(
              _store.titlePage ?? widget.stepByStepModel.name,
              style: AppTypo.p2(color: AppColors.highlightColor),
            );
          },
        ),
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
                    allowImplicitScrolling: false,
                    onPageChanged: _store.onPageChange,
                    children: pages,
                    controller: _store.pageController,
                  ),
                ),
                StepByStepNavigation(store: _store),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StepByStepNavigation extends StatelessWidget {
  const StepByStepNavigation({
    Key? key,
    required StepByStepStore store,
  })  : _store = store,
        super(key: key);

  final StepByStepStore _store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(16),
            vertical: SizeConverter.relativeHeight(32),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: _store.page > 0,
                child: BackView(
                  onTap: () => _store.backPage(),
                  title: 'Voltar',
                ),
                replacement: Container(),
              ),
              NextView(
                onTap: () => _store.nextPage(),
                title: 'Preparar receita',
              ),
            ],
          ),
        );
      },
    );
  }
}
