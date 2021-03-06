import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/ingredient_model.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/recipe_section.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/chef_tip_section.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/ingredient_list.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_by_step_model.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_by_step_store.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/back_view.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/ingredient_check_list_view.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/next_view.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/step_by_step_navigation.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/step_view.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/secondary_app_bar.dart';
import 'package:pratudo/features/widgets/spacing.dart';

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
    _store.model = widget.stepByStepModel;
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
        stepsLength[section.step] = section.items.length;
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
        children: [
          InkWell(
            onTap: () {
              buildChefTipBottomSheet(
                context,
                widget.stepByStepModel.chefTips,
              );
            },
            child: Icon(
              LineAwesomeIcons.hand_holding_heart,
              size: SizeConverter.fontSize(24),
              color: AppColors.greyColor,
            ),
          ),
          Spacing(width: 16),
          InkWell(
            onTap: () {
              buildIngredientsBottomSheet(
                context,
                widget.stepByStepModel.ingredients,
              );
            },
            child: Icon(
              LineAwesomeIcons.blender,
              size: SizeConverter.fontSize(24),
              color: AppColors.greyColor,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderStep(store: _store),
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
                StepByStepNavigation(
                  store: _store,
                  step: widget.stepByStepModel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildChefTipBottomSheet(
    BuildContext context,
    String chefTip,
  ) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (builder) {
        return BaseBottomSheet(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChefTipSection(
                      text: chefTip,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> buildIngredientsBottomSheet(
    BuildContext context,
    List<IngredientModel> ingredients,
  ) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      constraints: BoxConstraints(maxHeight: 400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (builder) {
        return BaseBottomSheet(
          child: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  child: IngredientsListSection(
                    ingredients: ingredients,
                    unitsOfMeasure: recipeHelpersStore.units,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HeaderStep extends StatelessWidget {
  const HeaderStep({
    Key? key,
    required StepByStepStore store,
  })  : _store = store,
        super(key: key);

  final StepByStepStore _store;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Observer(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConverter.relativeWidth(16),
            ),
            child: Column(
              children: [
                Text(
                  'Vamos ao preparo!',
                  style: AppTypo.h2(color: AppColors.darkestColor),
                ),
                if (_store.page == 0) ...[
                  Spacing(
                    height: 16,
                  ),
                  Text(
                    'Hora de conferir o que tem na sua cozinha',
                    textAlign: TextAlign.center,
                    style: AppTypo.h2(color: AppColors.darkestColor),
                  ),
                ],
                if (_store.page > 0) ...[
                  Spacing(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: _store.hasPreviousSection,
                        child: BackView(
                          title: 'Voltar se????o',
                          onTap: () => _store.jumpToPreviousSection(),
                          color: AppColors.blueColor,
                        ),
                        replacement: Container(),
                      ),
                      Spacing(width: 8),
                      Visibility(
                        visible: _store.hasNextSection,
                        child: NextView(
                          title: 'Pr??xima se????o',
                          onTap: () => _store.jumpToNextSection(),
                          color: AppColors.blueColor,
                        ),
                        replacement: Container(),
                      ),
                    ],
                  ),
                ],
                if (_store.page > 0) ...[
                  Spacing(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_store.currentlyPositionInStep} de'
                              ' ${_store.stepLength[_store.titlePage]}',
                              style: AppTypo.p3(
                                color: AppColors.darkestColor,
                              ),
                            ),
                            Spacing(height: 4),
                            LinearPercentIndicator(
                              lineHeight: 8.0,
                              padding: EdgeInsets.zero,
                              animation: true,
                              animateFromLastPercent: true,
                              percent: _store.percentProgress,
                              progressColor: AppColors.highlightColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
