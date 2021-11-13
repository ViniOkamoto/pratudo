import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/category_dropdown.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/multi_select_form_field.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _recipeHelpersStore.getCategories(withLoadingOverlay: true);
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
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: SizeConverter.relativeHeight(16),
          horizontal: SizeConverter.relativeWidth(24),
        ),
        children: [
          Column(
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
                labelText: "Nome da receita",
                onChanged: (value) {},
                textEditingController: TextEditingController(),
                errorText: null,
                hintText: "Insira nome da receita",
              ),
              Spacing(height: 16),
              AppTextField(
                labelText: "Descrição da receita",
                onChanged: (value) {},
                textEditingController: TextEditingController(),
                errorText: null,
                hintText: "Insira uma descrição da receita",
              ),
              Spacing(height: 16),
              MultiSelectFormField<RecipeHelperModel>(
                label: "Categoria da receita",
                onConfirm: (value) {},
                builderElement: _recipeHelpersStore.categories
                    .map((e) => CustomMultiSelectItem(
                          label: e.value,
                          value: e,
                        ))
                    .toList(),
                itemsList: _recipeHelpersStore.categories,
                onTapChipSelected: (value) {},
                selectedItems: [],
                hintText: "Selecione as categorias",
                bottomSheetTitle: "Categorias de comida",
              ),
              Spacing(height: 16),
              DifficultyDropdown(
                difficultyList: difficultyList,
                onChanged: (value) {},
                value: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
