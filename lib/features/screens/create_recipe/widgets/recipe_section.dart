import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
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
                              hintText: 'Insira um título: "Para Massa", "Para cobertura"',
                              onChanged: (value) => _formSectionStore.setSectionName(value, sectionIndex),
                              controller: _formSectionStore.sectionNameControllers[sectionIndex],
                              textInputAction: TextInputAction.done,
                              errorText: _formSectionStore.sectionNameErrors[sectionIndex]['error'],
                              isBigTextField: true,
                            ),
                          ),
                        ),
                        Spacing(width: 8),
                        OptionMenu(
                          onTapDelete: () {
                            _formSectionStore.removeSection(sectionIndex);
                            FocusScope.of(context).requestFocus(FocusNode());
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
                        Text(
                          'Sem estimativa',
                          style: AppTypo.p4(color: AppColors.grayColor),
                        ),
                      ],
                    ),
                    Spacing(height: 24),
                    IngredientsSection(
                      recipeHelpersStore: _recipeHelpersStore,
                      formSectionStore: _formSectionStore,
                      sectionIndex: sectionIndex,
                      ingredients: _formSectionStore.sections[sectionIndex].ingredients,
                      onTapDelete: _formSectionStore.removeIngredient,
                      onTapAdd: () => _formSectionStore.addIngredient(sectionIndex),
                      ingredientNameControllers: _formSectionStore.ingredientNameControllers,
                      quantityControllers: _formSectionStore.quantityControllers,
                      onChangedIngredientName: _formSectionStore.setIngredientName,
                      onChangedIngredientQuantity: _formSectionStore.setIngredientQuantity,
                    ),
                    Spacing(height: 24),
                    StepByStepSection(),
                    if (_formSectionStore.sections.length == (sectionIndex + 1)) ...[
                      Spacing(height: 24),
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
          onTap: onTap,
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
        color: AppColors.grayColor,
      ),
      iconSize: SizeConverter.fontSize(16),
    );
  }
}
