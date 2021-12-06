import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/rate_and_comment/rate_and_comment_store.dart';
import 'package:pratudo/features/widgets/app_outline_button.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/base_modal.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class RateAndCommentModal extends StatefulWidget {
  final String recipeName;
  final String recipeId;
  const RateAndCommentModal({
    Key? key,
    required this.recipeName,
    required this.recipeId,
  }) : super(key: key);

  @override
  _RateAndCommentModalState createState() => _RateAndCommentModalState();
}

class _RateAndCommentModalState extends State<RateAndCommentModal> {
  final RateAndCommentStore store = serviceLocator<RateAndCommentStore>();
  @override
  Widget build(BuildContext context) {
    return BaseModal(
      height: 600,
      title: '',
      body: Observer(
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Avaliando ${widget.recipeName}',
                      style: AppTypo.h2(color: AppColors.darkerColor),
                      textAlign: TextAlign.center,
                    ),
                    Spacing(height: 24),
                    RateRow(
                      value: store.rate,
                      onTap: store.setRate,
                    ),
                    Spacing(height: 24),
                    AppTextField(
                      labelText: 'Deixe um comentário',
                      hintText: 'Deixe algum comentário',
                      onChanged: store.setContent,
                      textEditingController: store.commentController,
                    ),
                    Spacing(height: 48),
                    AppPrimaryButton(
                      text: 'Avaliar receita',
                      onPressed: () {
                        store.rateAndComment(widget.recipeId, context);
                      },
                    ),
                    BackToRecipe(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class BackToRecipe extends StatelessWidget {
  const BackToRecipe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppOutlinedButton(
      text: 'Voltar para receita',
      onPressed: () {
        Navigator.popUntil(
          context,
          ModalRoute.withName(Routes.detailedRecipe),
        );
      },
    );
  }
}

class RateRow extends StatelessWidget {
  const RateRow({
    Key? key,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  final Function(double) onTap;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RateButton(
          rateValue: 1,
          value: value,
          onTapRate: onTap,
        ),
        Spacing(width: 16),
        RateButton(
          rateValue: 2,
          value: value,
          onTapRate: onTap,
        ),
        Spacing(width: 16),
        RateButton(
          rateValue: 3,
          value: value,
          onTapRate: onTap,
        ),
        Spacing(width: 16),
        RateButton(
          rateValue: 4,
          value: value,
          onTapRate: onTap,
        ),
        Spacing(width: 16),
        RateButton(
          rateValue: 5,
          value: value,
          onTapRate: onTap,
        ),
      ],
    );
  }
}

class RateButton extends StatelessWidget {
  const RateButton(
      {Key? key,
      required this.rateValue,
      required this.value,
      required this.onTapRate})
      : super(key: key);
  final double rateValue;
  final double value;
  final Function(double) onTapRate;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapRate(rateValue);
      },
      child: Icon(
        value >= rateValue ? LineAwesomeIcons.star_1 : LineAwesomeIcons.star,
        size: SizeConverter.fontSize(24),
        color: AppColors.yellowColor,
      ),
    );
  }
}
