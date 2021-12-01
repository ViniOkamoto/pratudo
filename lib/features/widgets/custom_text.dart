import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.maxLines = 2,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    this.textAlign = TextAlign.start,
    this.highlightTextColor = AppColors.highlightColor,
    this.fontWeight,
  }) : super(key: key);

  final String text;
  final int maxLines;
  final TextOverflow overflow;
  final TextStyle? style;
  final TextAlign textAlign;
  final Color highlightTextColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return EasyRichText(
      text,
      defaultStyle: style ?? AppTypo.p5(color: AppColors.darkColor),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: TextAlign.center,
      patternList: [
        EasyRichTextPattern(
          targetString: '(\\*)(.*?)(\\*)',
          matchBuilder: (BuildContext context, RegExpMatch? match) {
            return TextSpan(
              text: match![0]?.replaceAll('*', ''),
              style: TextStyle()
                  .copyWith(color: highlightTextColor, fontWeight: fontWeight),
            );
          },
        ),
      ],
    );
  }
}
