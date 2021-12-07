import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/datasources/recipe/recipe_query_params.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/multi_select_form_field.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/portions_field.dart';
import 'package:pratudo/features/screens/main/widgets/filter_modal/filter_store.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_enum.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/app_small_button.dart';
import 'package:pratudo/features/widgets/base_modal.dart';
import 'package:pratudo/features/widgets/custom_multi_select_bottom_sheet/custom_multi_select_item.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class FilterModal extends StatelessWidget {
  FilterModal({
    Key? key,
    required this.helpersStore,
    required this.onPressToFilter,
    required this.type,
  }) : super(key: key);

  final RecipeHelpersStore helpersStore;
  final Function(RecipeQueryParams) onPressToFilter;
  final SearchTypeEnum? type;
  final FilterStore filterStore = serviceLocator<FilterStore>();

  @override
  Widget build(BuildContext context) {
    return BaseModal(
      title: 'Filtros',
      height: 500,
      body: Observer(
        builder: (context) {
          return Expanded(
            child: Scrollbar(
              child: ListView(
                padding: EdgeInsets.only(
                  bottom: SizeConverter.relativeHeight(24),
                ),
                physics: BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            if (type != SearchTypeEnum.CATEGORY)
                              MultiSelectFormField<RecipeHelperModel>(
                                label: 'Filtros de categoria',
                                onConfirm: filterStore.setCategory,
                                builderElement: helpersStore.categories
                                    .map((e) => CustomMultiSelectItem(
                                          label: e.value,
                                          value: e,
                                        ))
                                    .toList(),
                                itemsList: helpersStore.categories,
                                onTapChipSelected: filterStore.unsetCategory,
                                selectedItems: filterStore.categories,
                                hintText: 'Selecione as categorias',
                                bottomSheetTitle: 'Categorias de comida',
                              ),
                            Spacing(height: 16),
                            MultiSelectFormField<DifficultyEnum>(
                              label: 'Filtros de dificuldade',
                              onConfirm: filterStore.setDifficulty,
                              builderElement: difficultyList
                                  .map(
                                    (e) => CustomMultiSelectItem(
                                      label: e.label,
                                      value: e,
                                    ),
                                  )
                                  .toList(),
                              itemsList: difficultyList,
                              onTapChipSelected: filterStore.unsetDifficulty,
                              selectedItems: filterStore.difficulties,
                              hintText: 'Selecione dificuldades',
                              bottomSheetTitle: 'Dificuldades de receita',
                            ),
                            Spacing(height: 16),
                            PortionsField(
                              onTapLess: filterStore.onTapLess,
                              onTapMore: filterStore.onTapMore,
                              portionValue: filterStore.portion,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottom: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConverter.relativeHeight(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSmallButton(
              text: 'Cancelar',
              onPressed: () => Navigator.pop(context),
              borderColor: AppColors.greyColor,
              buttonColor: AppColors.greyColor,
              textColor: AppColors.whiteColor,
            ),
            Spacing(width: 16),
            AppSmallButton(
              text: 'Filtrar receitas',
              onPressed: () {
                List<String>? categories;
                if (type != SearchTypeEnum.CATEGORY) {
                  categories = filterStore.categories
                      .map((element) => element.key)
                      .toList();
                }
                this.onPressToFilter(
                  RecipeQueryParams(
                    categories: categories,
                    difficulties: filterStore.difficulties
                        .map((element) => element.key)
                        .toList(),
                    portions: filterStore.portion > 0
                        ? filterStore.portion.toString()
                        : '',
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color buttonColor;
  final Color borderColor;
  final Color inactiveBorderColor;
  final Color textColor;
  final IconData? icon;
  final double iconSize;

  const FilterButton(
      {this.onPressed,
      this.icon,
      required this.text,
      this.buttonColor = AppColors.darkColor,
      this.borderColor = AppColors.darkColor,
      this.textColor = AppColors.darkColor,
      this.inactiveBorderColor = AppColors.lightestHighlightColor,
      this.iconSize = 8});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(8),
        ),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.symmetric(
            horizontal: BorderSide(
              color: borderColor,
            ),
            vertical: BorderSide(
              color: borderColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: AppTypo.p5(color: textColor),
            ),
            if (icon != null) ...[
              Spacing(width: 8),
              Icon(
                icon!,
                size: SizeConverter.fontSize(iconSize),
                color: textColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
