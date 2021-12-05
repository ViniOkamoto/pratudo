import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_store.dart';
import 'package:pratudo/features/widgets/app_icon_button.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class StepView extends StatefulWidget {
  final StepByStepCreation step;
  final String sectionName;
  const StepView({
    required this.step,
    required this.sectionName,
  });

  @override
  _StepViewState createState() => _StepViewState();
}

class _StepViewState extends State<StepView> {
  final StepStore stepStore = serviceLocator<StepStore>();
  @override
  void initState() {
    stepStore.checkIfIsAStepWithTime(widget.step);
    super.initState();
  }

  @override
  void dispose() {
    stepStore.controller = CountdownController(
      duration: Duration(minutes: 0),
    );
    stepStore.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.step.description!,
                    style: AppTypo.p3(color: AppColors.darkColor),
                  ),
                  if (stepStore.stepWithTime != null) ...[
                    Observer(builder: (context) {
                      return Column(
                        children: [
                          Spacing(height: 40),
                          Icon(
                            LineAwesomeIcons.clock,
                            size: SizeConverter.fontSize(132),
                            color: AppColors.blueColor,
                          ),
                          Countdown(
                            countdownController: stepStore.controller!,
                            builder: (context, duration) {
                              return Text(
                                _getTime(duration),
                                style: AppTypo.p1(
                                  color: AppColors.blueColor,
                                ),
                              );
                            },
                          ),
                          Spacing(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppIconButton(
                                onTap: () => stepStore.startTimer(),
                                iconData: LineAwesomeIcons.play,
                                borderColor: Colors.green,
                                iconColor: Colors.green,
                              ),
                              Spacing(width: 24),
                              AppIconButton(
                                onTap: () => stepStore.pauseTimer(),
                                iconData: LineAwesomeIcons.pause,
                              ),
                              Spacing(width: 24),
                              AppIconButton(
                                onTap: () => stepStore.restartTimer(),
                                iconData: LineAwesomeIcons.stop,
                                iconColor: AppColors.greyColor,
                                borderColor: AppColors.greyColor,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getTime(Duration duration) {
    final hours = _stringTwoDigits(duration.inHours);
    final minutes = _stringTwoDigits(duration.inMinutes.remainder(60));
    final seconds = _stringTwoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  _stringTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}
