import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/screens/create_recipe/form_section_store.dart';
import 'package:pratudo/features/screens/create_recipe/recipe_form_store.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/difficulty_dropdown.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/multi_select_form_field.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/portions_field.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/recipe_section.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/app_outline_button.dart';
import 'package:pratudo/features/widgets/app_small_button.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/custom_multi_select_bottom_sheet/custom_multi_select_item.dart';
import 'package:pratudo/features/widgets/secondary_app_bar.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({Key? key}) : super(key: key);

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final RecipeHelpersStore _recipeHelpersStore = serviceLocator<RecipeHelpersStore>();
  final RecipeFormStore _recipeFormStore = serviceLocator<RecipeFormStore>();
  final FormSectionStore _formSectionStore = serviceLocator<FormSectionStore>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _recipeHelpersStore.getDataForForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        children: [
          AppSmallButton(
            onPressed: () {},
            text: 'Gravar',
            buttonColor: AppColors.whiteColor,
            textColor: AppColors.highlightColor,
          ),
          Spacing(width: 8),
          AppSmallButton(
            onPressed: null,
            text: 'Publicar',
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          return ListView(
            padding: EdgeInsets.symmetric(
              vertical: SizeConverter.relativeHeight(16),
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConverter.relativeWidth(24),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(
                          left: SizeConverter.relativeWidth(64),
                          right: SizeConverter.relativeWidth(64),
                          top: SizeConverter.relativeHeight(8),
                          bottom: SizeConverter.relativeHeight(32),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.highlightColor,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(
                                    LineAwesomeIcons.alternate_cloud_upload,
                                    size: SizeConverter.fontSize(56),
                                    color: AppColors.lightGrayColor,
                                  ),
                                  Text(
                                    'Clique aqui para subir uma imagem da receita',
                                    style: AppTypo.p4(color: AppColors.lightGrayColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacing(height: 24),
                    AppTextField(
                      labelText: 'Nome da receita',
                      onChanged: _recipeFormStore.setRecipeName,
                      textEditingController: _recipeFormStore.recipeNameController,
                      errorText: _recipeFormStore.errorRecipeName,
                      hintText: 'Insira nome da receita',
                    ),
                    Spacing(height: 16),
                    AppTextField(
                      isOptional: true,
                      labelText: 'Descrição da receita',
                      onChanged: _recipeFormStore.setDescription,
                      textEditingController: _recipeFormStore.descriptionController,
                      hintText: 'Insira uma descrição da receita',
                    ),
                    Spacing(height: 16),
                    MultiSelectFormField<RecipeHelperModel>(
                      label: 'Categoria da receita',
                      onConfirm: _recipeFormStore.setCategory,
                      builderElement: _recipeHelpersStore.categories
                          .map((e) => CustomMultiSelectItem(
                                label: e.value,
                                value: e,
                              ))
                          .toList(),
                      itemsList: _recipeHelpersStore.categories,
                      onTapChipSelected: _recipeFormStore.unsetCategory,
                      selectedItems: _recipeFormStore.categories,
                      hintText: 'Selecione as categorias',
                      bottomSheetTitle: 'Categorias de comida',
                    ),
                    Spacing(height: 16),
                    DifficultyDropdown(
                      difficuties: difficultyList,
                      onChanged: _recipeFormStore.setDifficulty,
                      value: _recipeFormStore.difficulty,
                    ),
                    Spacing(height: 24),
                    PortionsField(
                      onTapLess: _recipeFormStore.onTapLess,
                      onTapMore: _recipeFormStore.onTapMore,
                      portionValue: _recipeFormStore.portion,
                    ),
                    Spacing(height: 24),
                    AppTextField(
                      labelText: 'Dica da receita',
                      onChanged: _recipeFormStore.setChefTip,
                      textEditingController: _recipeFormStore.chefTipController,
                      isBigText: true,
                      hintText: 'Insira alguma dica',
                      isOptional: true,
                    ),
                    Spacing(height: 24),
                    if (_formSectionStore.sections.isEmpty)
                      AppOutlinedButton(
                        onPressed: _formSectionStore.addSection,
                        text: 'Adicionar Seção',
                        primaryColor: AppColors.blueColor,
                      ),
                  ],
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _StepDivider(),
                      RecipeSection(
                        sectionIndex: index,
                        recipeHelpersStore: _recipeHelpersStore,
                        formSectionStore: _formSectionStore,
                      ),
                    ],
                  );
                },
                itemCount: _formSectionStore.sections.length,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StepDivider extends StatelessWidget {
  const _StepDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 8,
      height: 24,
      color: AppColors.lightestGrayColor,
    );
  }
}
