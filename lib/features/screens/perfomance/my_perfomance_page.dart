import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/recipe_section.dart';
import 'package:pratudo/features/stores/shared/user_progress_store.dart';
import 'package:pratudo/features/widgets/custom_text.dart';
import 'package:pratudo/features/widgets/secondary_app_bar.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class MyPerformancePage extends StatelessWidget {
  final UserProgressStore userProgressStore =
      serviceLocator<UserProgressStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        text: 'Meu desempenho',
      ),
      body: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Spacing(height: 24),
                    _UserLevel(
                      level: userProgressStore.userProgress!.level,
                      percentage:
                          userProgressStore.userProgress!.experience.percentage,
                      currentExp:
                          userProgressStore.userProgress!.experience.current,
                      totalExp: userProgressStore.userProgress!.experience.from,
                    ),
                    Spacing(height: 8),
                    Text(
                      'Nível ${userProgressStore.userProgress!.level}',
                      style: AppTypo.p2(color: AppColors.darkestColor),
                    ),
                    Text(
                      '${userProgressStore.userProgress!.title}',
                      style: AppTypo.p1(color: AppColors.orangeColor),
                    ),
                    Spacing(height: 24),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Emblemas',
                                  style:
                                      AppTypo.p2(color: AppColors.darkestColor),
                                ),
                                Text(
                                  '3 de 5 emblemas',
                                  style: AppTypo.p5(color: AppColors.blueColor),
                                ),
                                Spacing(height: 16),
                                Flexible(
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: SizeConverter.relativeWidth(32),
                                    runSpacing: SizeConverter.relativeWidth(24),
                                    children: [
                                      EmblemWidget(
                                        emblemColor: Color(0xFF83C4FF),
                                        icon: LineAwesomeIcons.award,
                                        title: 'Bem vindo a família',
                                        description:
                                            'Por ser um dos nosso *primeiros usuários*,'
                                            ' ficamos muito felizes, *seja bem vindo a cozinha*!',
                                        isBlocked: false,
                                      ),
                                      EmblemWidget(
                                        emblemColor: AppColors.orangeColor,
                                        icon: LineAwesomeIcons.burn,
                                        title: 'Algo pegou fogo!',
                                        description:
                                            'Por ter uma *receita* nos *populares*',
                                        isBlocked: false,
                                      ),
                                      EmblemWidget(
                                        emblemColor: Color(0xFFB8FB84),
                                        icon: LineAwesomeIcons.leaf,
                                        title: 'Amante da natureza',
                                        description:
                                            'Realizou uma receita com categoria *vegetariana*!',
                                        isBlocked: false,
                                      ),
                                      EmblemWidget(
                                        emblemColor: AppColors.yellowColor,
                                        icon: LineAwesomeIcons.book_reader,
                                        title: 'Leitor mirim',
                                        description:
                                            'Por ter realizado 5 ou mais *receitas*',
                                        isBlocked: true,
                                      ),
                                      EmblemWidget(
                                        emblemColor: AppColors.yellowColor,
                                        icon: LineAwesomeIcons.cookie,
                                        title: 'Biscoitero',
                                        description:
                                            'Por estar realizar mais de 5 *receitas*',
                                        isBlocked: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class EmblemWidget extends StatelessWidget {
  const EmblemWidget({
    Key? key,
    required this.icon,
    required this.emblemColor,
    required this.title,
    required this.description,
    required this.isBlocked,
  }) : super(key: key);
  final IconData icon;
  final Color emblemColor;
  final String title;
  final String description;
  final bool isBlocked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isBlocked) {
          buildEmblemBottomSheet(
            context,
            title,
            icon,
            description,
            emblemColor,
          );
        }
      },
      child: Column(
        children: [
          SizedBox(
            width: SizeConverter.fontSize(56),
            height: SizeConverter.fontSize(56),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: SizeConverter.fontSize(30),
                    height: SizeConverter.fontSize(30),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: isBlocked
                              ? AppColors.lightGrayColor
                              : emblemColor,
                          blurRadius: 20,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: HexagonWidget.pointy(
                    width: SizeConverter.fontSize(56),
                    height: SizeConverter.fontSize(56),
                    color: isBlocked
                        ? AppColors.lightGrayColor
                        : AppColors.whiteColor,
                    child: Icon(
                      icon,
                      size: SizeConverter.fontSize(32),
                      color: isBlocked ? AppColors.whiteColor : emblemColor,
                    ),
                  ),
                ),
                if (isBlocked)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: SizeConverter.fontSize(16),
                      height: SizeConverter.fontSize(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.darkColor,
                      ),
                      child: Icon(
                        Icons.lock,
                        color: AppColors.whiteColor,
                        size: SizeConverter.fontSize(8),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Spacing(height: 8),
          Container(
            width: 52,
            child: Text(
              title,
              style: AppTypo.smallText(color: AppColors.darkColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildEmblemBottomSheet(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    Color color,
  ) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (builder) {
        return BaseBottomSheet(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTypo.h3(color: AppColors.darkColor),
                    ),
                    Spacing(
                      height: 24,
                    ),
                    Icon(
                      icon,
                      size: SizeConverter.fontSize(80),
                      color: color,
                    ),
                    Spacing(height: 16),
                    Text(
                      'Você ganhou esse emblema porque:',
                      style: AppTypo.p4(color: AppColors.darkColor),
                    ),
                    Spacing(height: 8),
                    CustomText(
                      text: description,
                      highlightTextColor: color,
                      style: AppTypo.p3(color: AppColors.darkColor),
                      textAlign: TextAlign.center,
                    ),
                    Spacing(height: 24),
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

class _UserLevel extends StatelessWidget {
  const _UserLevel({
    Key? key,
    required this.level,
    required this.percentage,
    required this.currentExp,
    required this.totalExp,
  }) : super(key: key);

  final int level;
  final double percentage;
  final int currentExp;
  final int totalExp;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: SizeConverter.fontSize(300),
      animation: true,
      animationDuration: 1200,
      backgroundColor: AppColors.lightestGrayColor,
      lineWidth: 14,
      circularStrokeCap: CircularStrokeCap.round,
      percent: percentage / 100,
      progressColor: AppColors.orangeColor,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LineAwesomeIcons.trophy,
            color: AppColors.orangeColor,
            size: SizeConverter.fontSize(86),
          ),
          Spacing(
            height: 4,
          ),
          Text(
            'Experiência',
            style: AppTypo.h3(color: AppColors.darkerColor),
          ),
          Spacing(
            height: 4,
          ),
          Text(
            '$currentExp/$totalExp',
            style: AppTypo.h3(color: AppColors.darkerColor),
          ),
        ],
      ),
    );
  }
}
