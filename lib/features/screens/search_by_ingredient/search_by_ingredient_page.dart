import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/search_by_ingredient/search_by_ingredient_store.dart';
import 'package:pratudo/features/screens/search_by_ingredient/widgets/ingredient_tile_widget.dart';
import 'package:pratudo/features/widgets/app_field.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/secondary_app_bar.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class SearchByIngredientPage extends StatefulWidget {
  @override
  State<SearchByIngredientPage> createState() => _SearchByIngredientPageState();
}

class _SearchByIngredientPageState extends State<SearchByIngredientPage> {
  final SearchByIngredientStore _store = serviceLocator<SearchByIngredientStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        text: 'Pesquisa por Ingredientes',
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: SizeConverter.relativeHeight(24),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderPage(store: _store),
                  _IngredientsList(store: _store),
                  Observer(
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: AppPrimaryButton(
                          text: "Encontrar receita",
                          icon: LineAwesomeIcons.search,
                          onPressed: _store.validSearch
                              ? () {
                                  _store.findRecipe(context);
                                }
                              : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientsList extends StatelessWidget {
  const _IngredientsList({
    Key? key,
    required SearchByIngredientStore store,
  })  : _store = store,
        super(key: key);

  final SearchByIngredientStore _store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: SizeConverter.relativeWidth(16),
              right: SizeConverter.relativeWidth(16),
            ),
            itemBuilder: (BuildContext context, int index) {
              String ingredient = _store.ingredients[index];
              return IngredientTileWidget(
                ingredient: ingredient,
                index: index,
                onTapDelete: _store.removeIngredient,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Spacing(height: 16);
            },
            itemCount: _store.ingredients.length,
          ),
        );
      },
    );
  }
}

class _HeaderPage extends StatelessWidget {
  const _HeaderPage({
    Key? key,
    required SearchByIngredientStore store,
  })  : _store = store,
        super(key: key);

  final SearchByIngredientStore _store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'O que tem na sua cozinha?',
                style: AppTypo.h2(
                  color: AppColors.darkestColor,
                ),
              ),
              Spacing(height: 4),
              Text(
                'Adicione ao menos 2 ingredientes',
                style: AppTypo.p5(
                  color: AppColors.blueColor,
                ),
              ),
              Spacing(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppField(
                      hintText: 'Adicione o seu ingrediente',
                      controller: _store.ingredientField,
                      onChanged: _store.setIngredient,
                      verticalPadding: 16,
                      errorText: _store.errorText,
                    ),
                  ),
                  Spacing(width: 8),
                  InkWell(
                    onTap: () => _store.addIngredient(),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.darkHighlightColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          LineAwesomeIcons.plus,
                          color: AppColors.whiteColor,
                          size: SizeConverter.fontSize(32),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacing(height: 24),
              Padding(
                padding: EdgeInsets.only(
                  right: SizeConverter.relativeWidth(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ingredientes selecionados',
                      style: AppTypo.p2(color: AppColors.darkColor),
                    ),
                    Text(
                      '${_store.ingredients.length}',
                      style: AppTypo.p2(color: AppColors.highlightColor),
                    ),
                  ],
                ),
              ),
              Spacing(height: 16),
            ],
          ),
        );
      },
    );
  }
}
