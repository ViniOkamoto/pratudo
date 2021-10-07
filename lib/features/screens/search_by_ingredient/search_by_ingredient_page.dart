import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/app_field.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/secondary_app_bar.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class SearchByIngredientPage extends StatelessWidget {
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
                  Padding(
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
                          children: [
                            Expanded(
                              child: AppField(
                                hintText: 'Adicione o seu ingrediente',
                                controller: TextEditingController(),
                                onChanged: (onChanged) {},
                                verticalPadding: 16,
                              ),
                            ),
                            Spacing(width: 8),
                            Container(
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
                                '3',
                                style: AppTypo.p2(color: AppColors.highlightColor),
                              ),
                            ],
                          ),
                        ),
                        Spacing(height: 16),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: SizeConverter.relativeWidth(16),
                        right: SizeConverter.relativeWidth(16),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.only(
                            top: SizeConverter.relativeHeight(12),
                            bottom: SizeConverter.relativeHeight(12),
                            left: SizeConverter.relativeWidth(16),
                            right: SizeConverter.relativeWidth(8),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackWith25Opacity,
                                offset: Offset(0, 4),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lorem Ipsum',
                                style: AppTypo.p3(color: AppColors.darkerColor),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  LineAwesomeIcons.alternate_trash,
                                  size: SizeConverter.fontSize(26),
                                  color: AppColors.lightGrayColor,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Spacing(height: 16);
                      },
                      itemCount: 5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: AppPrimaryButton(
                      text: "Encontrar receita",
                      icon: LineAwesomeIcons.search,
                      onPressed: () {},
                    ),
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
