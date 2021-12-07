import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';
import 'package:pratudo/features/models/time_model.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class CachedCarouselItem extends StatefulWidget {
  const CachedCarouselItem({
    required this.recipe,
  });

  final CacheRecipeModel recipe;

  @override
  _CachedCarouselItemState createState() => _CachedCarouselItemState();
}

class _CachedCarouselItemState extends State<CachedCarouselItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.cachedRecipe,
        arguments: widget.recipe,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: SizeConverter.relativeWidth(20),
          horizontal: SizeConverter.relativeWidth(1),
        ),
        width: SizeConverter.relativeWidth(268),
        decoration: BoxDecoration(
          color: AppColors.lightestGrayColor,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: MemoryImage(
              ImageHelper.convertBase64ToImage(widget.recipe.images.first),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackWith25Opacity,
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  _PreparationHeader(
                    preparationTime: widget.recipe.totalMethodOfPreparationTime,
                  ),
                  _PortionHeader(
                    text: widget.recipe.portions,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: SizeConverter.relativeHeight(60),
                        padding: EdgeInsets.only(
                          left: SizeConverter.relativeWidth(16),
                          right: SizeConverter.relativeWidth(8),
                          top: SizeConverter.relativeHeight(8),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0x660000000),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 7,
                                        child: Text(
                                          widget.recipe.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: AppTypo.h3(
                                              color: AppColors.whiteColor),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              LineAwesomeIcons.star_1,
                                              size: SizeConverter.fontSize(10),
                                              color: AppColors.yellowColor,
                                            ),
                                            Spacing(width: 4),
                                            Flexible(
                                              child: Text(
                                                "(${widget.recipe.rate.toStringAsFixed(1)})",
                                                style: AppTypo.p5(
                                                    color:
                                                        AppColors.yellowColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Feito por: ${widget.recipe.owner.name}",
                                    style:
                                        AppTypo.a2(color: AppColors.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PreparationHeader extends StatelessWidget {
  const _PreparationHeader({
    required this.preparationTime,
  });

  final TimeModel preparationTime;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(8),
          vertical: SizeConverter.relativeHeight(8),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: AppColors.blueColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LineAwesomeIcons.clock,
              size: SizeConverter.fontSize(16),
              color: AppColors.whiteColor,
            ),
            Spacing(width: 4),
            Text(
              preparationTime.convertTimeToString(),
              style: AppTypo.p5(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortionHeader extends StatelessWidget {
  const _PortionHeader({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(8),
          vertical: SizeConverter.relativeHeight(8),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          color: AppColors.orangeColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LineAwesomeIcons.user,
              size: SizeConverter.fontSize(16),
              color: AppColors.whiteColor,
            ),
            Spacing(width: 4),
            Text(
              text,
              style: AppTypo.p5(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
