import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    Key? key,
    required RecipeHelpersStore recipeHelpersStore,
    required this.onPressedFilter,
    required this.filterSelected,
  })  : _recipeHelpersStore = recipeHelpersStore,
        super(key: key);

  final RecipeHelpersStore _recipeHelpersStore;
  final Function(RecipeHelperModel) onPressedFilter;
  final RecipeHelperModel filterSelected;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return SizedBox(
          height: SizeConverter.relativeHeight(30),
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    left: SizeConverter.relativeWidth(16),
                  ),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    RecipeHelperModel filter = _recipeHelpersStore.filters[index];
                    return _Filter(
                      onPressedFilter: onPressedFilter,
                      filter: filter,
                      isSelected: filterSelected.key == filter.key,
                    );
                  },
                  separatorBuilder: (context, index) => Spacing(width: 24),
                  itemCount: _recipeHelpersStore.filters.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Filter extends StatelessWidget {
  final bool isSelected;
  final Function(RecipeHelperModel) onPressedFilter;
  final RecipeHelperModel filter;
  const _Filter({
    this.isSelected = false,
    required this.onPressedFilter,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressedFilter(filter),
      child: Column(
        children: [
          Text(
            filter.value,
            style: AppTypo.p2(color: AppColors.darkColor),
          ),
          if (isSelected) ...[
            Spacing(height: 4),
            Container(
              width: SizeConverter.relativeWidth(6),
              height: SizeConverter.relativeWidth(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightestHighlightColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
