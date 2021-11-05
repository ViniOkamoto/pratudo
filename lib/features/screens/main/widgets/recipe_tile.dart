import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/widgets/spacing.dart';
import 'package:transparent_image/transparent_image.dart';

class RecipeTile extends StatefulWidget {
  final SummaryRecipe recipe;
  const RecipeTile({required this.recipe});

  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConverter.relativeWidth(16),
        right: SizeConverter.relativeWidth(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: SizeConverter.relativeWidth(45),
                    width: SizeConverter.relativeWidth(45),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.lightestGrayColor,
                        width: 1,
                      ),
                    ),
                    child: ClipOval(
                      child: FadeInImage(
                        image: MemoryImage(ImageHelper.convertBase64ToImage(widget.recipe.images.first)),
                        placeholder: MemoryImage(kTransparentImage),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Spacing(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.recipe.isNew)
                          Text(
                            "Nova Receita!",
                            style: AppTypo.p5(
                              color: AppColors.orangeColor,
                            ),
                          ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.recipe.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypo.h3(color: AppColors.darkestColor),
                                ),
                              ),
                              Spacing(width: 4),
                              Row(
                                children: [
                                  Icon(
                                    LineAwesomeIcons.star_1,
                                    color: AppColors.yellowColor,
                                    size: SizeConverter.fontSize(12),
                                  ),
                                  Text(
                                    "(${widget.recipe.rate})",
                                    style: AppTypo.p5(color: AppColors.yellowColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _RecipeInfo(
                              color: AppColors.blueColor,
                              icon: LineAwesomeIcons.clock,
                              text: widget.recipe.preparationTimeToString,
                            ),
                            Spacing(width: 8),
                            _RecipeInfo(
                              color: AppColors.orangeColor,
                              icon: LineAwesomeIcons.user,
                              text: widget.recipe.portions,
                            ),
                          ],
                        ),
                        Text(
                          "Feito por: ${widget.recipe.recipeOwner.name}",
                          style: AppTypo.p5(color: AppColors.darkColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            color: AppColors.lightGrayColor,
            iconSize: SizeConverter.fontSize(20),
            icon: Icon(LineAwesomeIcons.bookmark),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecipeInfo extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _RecipeInfo({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: SizeConverter.fontSize(12),
        ),
        Spacing(width: 4),
        Text(
          text,
          style: AppTypo.a2(color: color),
        ),
      ],
    );
  }
}
