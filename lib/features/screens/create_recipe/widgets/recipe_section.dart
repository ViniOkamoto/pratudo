import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';
import 'package:pratudo/features/models/time_model.dart';
import 'package:pratudo/features/screens/create_recipe/form_section_store.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/ingredients_section.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/step_by_step/step_by_step_section.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/app_outline_button.dart';
import 'package:pratudo/features/widgets/outlined_text_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class RecipeSection extends StatelessWidget {
  const RecipeSection({
    Key? key,
    required RecipeHelpersStore recipeHelpersStore,
    required FormSectionStore formSectionStore,
    required this.sectionIndex,
  })  : _recipeHelpersStore = recipeHelpersStore,
        _formSectionStore = formSectionStore,
        super(key: key);

  final RecipeHelpersStore _recipeHelpersStore;
  final FormSectionStore _formSectionStore;
  final int sectionIndex;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(24),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            child: OutlinedTextField(
                              hintText:
                                  'Insira um título: "Para Massa", "Para cobertura"',
                              onChanged: (value) => _formSectionStore
                                  .setSectionName(value, sectionIndex),
                              controller: _formSectionStore
                                  .sectionNameControllers[sectionIndex],
                              textInputAction: TextInputAction.done,
                              errorText: _formSectionStore
                                  .sectionNameErrors[sectionIndex]['error'],
                              isBigTextField: true,
                            ),
                          ),
                        ),
                        Spacing(width: 8),
                        OptionMenu(
                          onTapDelete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _formSectionStore.removeSection(sectionIndex);
                          },
                        ),
                      ],
                    ),
                    Spacing(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tempo de preparo da seção',
                          style: AppTypo.p3(color: AppColors.darkColor),
                        ),
                        Visibility(
                          visible:
                              _formSectionStore.sections[sectionIndex].time > 0,
                          child: Text(
                            TimeModel(
                              value:
                                  _formSectionStore.sections[sectionIndex].time,
                              unit: _formSectionStore
                                  .sections[sectionIndex].unit!,
                            ).convertTimeToString(),
                            style: AppTypo.p4(color: AppColors.greyColor),
                          ),
                          replacement: Text(
                            'Sem estimativa',
                            style: AppTypo.p4(color: AppColors.greyColor),
                          ),
                        ),
                      ],
                    ),
                    Spacing(height: 24),
                    IngredientsSection(
                      sectionIndex: sectionIndex,
                      recipeHelpersStore: _recipeHelpersStore,
                      formSectionStore: _formSectionStore,
                      ingredients:
                          _formSectionStore.sections[sectionIndex].ingredients,
                      ingredientNameControllers: _formSectionStore
                          .ingredientNameControllers[sectionIndex],
                      quantityControllers:
                          _formSectionStore.quantityControllers[sectionIndex],
                      onTapDelete: _formSectionStore.removeIngredient,
                      onTapAdd: () =>
                          _formSectionStore.addIngredient(sectionIndex),
                      onChangedIngredientName:
                          _formSectionStore.setIngredientName,
                      onChangedIngredientQuantity:
                          _formSectionStore.setIngredientQuantity,
                    ),
                    Spacing(height: 24),
                    StepByStepSection(
                      sectionIndex: sectionIndex,
                      steps: _formSectionStore.sections[sectionIndex].steps,
                      controllers: _formSectionStore
                          .stepDescriptionControllers[sectionIndex],
                      reorderStep: _formSectionStore.reorderStep,
                      onTapAdd: () => buildShowModalBottomSheet(context),
                      onTapDelete: _formSectionStore.removeStep,
                      onChangedStepDescription:
                          _formSectionStore.setStepDescription,
                      onChangedTime: _formSectionStore.setStepTime,
                    ),
                    Spacing(height: 24),
                    if (_formSectionStore.sections.length ==
                        (sectionIndex + 1)) ...[
                      AppOutlinedButton(
                        onPressed: _formSectionStore.addSection,
                        text: 'Adicionar Seção',
                        primaryColor: AppColors.blueColor,
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (builder) {
        return _BottomSheetStepField(
          formSectionStore: _formSectionStore,
          sectionIndex: sectionIndex,
        );
      },
    );
  }
}

class _BottomSheetStepField extends StatelessWidget {
  const _BottomSheetStepField({
    Key? key,
    required FormSectionStore formSectionStore,
    required this.sectionIndex,
  })  : _formSectionStore = formSectionStore,
        super(key: key);

  final FormSectionStore _formSectionStore;
  final int sectionIndex;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Campos do passo a passo',
                  style: AppTypo.p3(color: AppColors.darkColor),
                ),
                Spacing(height: 16),
                AppOutlinedButton(
                  onPressed: () {
                    _formSectionStore.addStep(sectionIndex, StepEnum.DEFAULT);
                    Navigator.pop(context);
                  },
                  text: 'Adicionar passo',
                ),
                Spacing(height: 16),
                AppOutlinedButton(
                  onPressed: () {
                    _formSectionStore.addStep(sectionIndex, StepEnum.WITH_TIME);
                    Navigator.pop(context);
                  },
                  text: 'Adicionar passo com tempo',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: child,
      ),
    );
  }
}

class AddOption extends StatelessWidget {
  const AddOption({
    required this.onTap,
    required this.label,
  });
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            onTap();
          },
          child: Row(
            children: [
              Icon(
                LineAwesomeIcons.plus,
                size: SizeConverter.fontSize(16),
                color: AppColors.highlightColor,
              ),
              Spacing(width: 8),
              Text(
                label,
                style: AppTypo.p3(color: AppColors.highlightColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OptionMenu extends StatelessWidget {
  const OptionMenu({
    required this.onTapDelete,
  });

  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 2,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text("Deletar seção"),
            onTap: onTapDelete,
          )
        ];
      },
      icon: Icon(
        LineAwesomeIcons.horizontal_ellipsis,
        color: AppColors.greyColor,
      ),
      iconSize: SizeConverter.fontSize(16),
    );
  }
}
