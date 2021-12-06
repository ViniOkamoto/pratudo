import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_by_step_model.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/rate_and_comment/rate_and_comment_modal.dart';

part 'step_by_step_store.g.dart';

class StepByStepStore = _StepByStepStoreBase with _$StepByStepStore;

abstract class _StepByStepStoreBase with Store {
  final PageController pageController = PageController();

  @observable
  int page = 0;

  @observable
  StepByStepModel? model;

  @observable
  Map<String, int> stepLength = {};

  @action
  setStepLength(Map<String, int> value) {
    stepLength = value;
    pageIntervals = _getIntervals();
  }

  @observable
  Map<String, Map<String, int>> pageIntervals = {};

  _getIntervals() {
    Map<String, Map<String, int>> pageIntervals = {};
    String lastSection = '';

    for (int index = 0; index < stepLength.keys.length; index++) {
      String section = stepLength.keys.elementAt(index);
      int startsIn = lastSection.isNotEmpty
          ? (pageIntervals[lastSection]!['endsIn']! + 1)
          : 1;
      int endsIn = startsIn + stepLength[section]! - 1;
      pageIntervals[section] = {
        'startsIn': startsIn,
        'endsIn': endsIn,
      };
      lastSection = section;
    }

    return pageIntervals;
  }

  @observable
  int currentlyStepStartsIn = 0;

  @observable
  int currentlyStepEndsIn = 0;

  @computed
  bool get hasStepInSection {
    if (page >= currentlyStepStartsIn && page < currentlyStepEndsIn) {
      return true;
    }
    return false;
  }

  @computed
  int get currentlyPositionInStep {
    int stepsRemaining = (currentlyStepEndsIn - this.page);
    int position = stepLength[titlePage!]! - stepsRemaining;
    return position;
  }

  @computed
  double get percentProgress {
    double percent = currentlyPositionInStep / stepLength[titlePage!]!;
    return percent;
  }

  @computed
  bool get hasNextSection {
    try {
      int currentlySection = pageIntervals.keys.toList().indexOf(titlePage!);

      return currentlySection < pageIntervals.length - 1;
    } catch (e) {
      return false;
    }
  }

  @computed
  bool get hasPreviousSection {
    try {
      int currentlyStep = pageIntervals.keys.toList().indexOf(titlePage!);

      return pageIntervals.keys.first !=
          pageIntervals.keys.elementAt(currentlyStep);
    } catch (e) {
      return false;
    }
  }

  @computed
  bool get canFinishRecipe {
    return !hasNextSection && !hasStepInSection && page > 0;
  }

  jumpToNextSection() {
    pageController.jumpToPage(currentlyStepEndsIn + 1);
  }

  jumpToPreviousSection() {
    int indexPreviousSection =
        pageIntervals.keys.toList().indexOf(titlePage!) - 1;
    pageController.jumpToPage(
        pageIntervals.values.elementAt(indexPreviousSection)['startsIn']!);
  }

  @observable
  String? titlePage;

  setTitlePage() {
    if (page > 0) {
      return titlePage = _getCurrentlySectionName();
    }
    return titlePage = null;
  }

  String _getCurrentlySectionName() {
    String currentlySection = '';
    pageIntervals.forEach((key, value) {
      if (page >= value['startsIn']! && page <= value['endsIn']!) {
        currentlySection = key;
        currentlyStepStartsIn = value['startsIn']!;
        currentlyStepEndsIn = value['endsIn']!;
      }
    });

    return currentlySection;
  }

  onPageChange(int index) {
    page = index;
    setTitlePage();
  }

  nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  backPage() {
    pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  finishRecipe(BuildContext context, String recipeName, String recipeId) async {
    if (model!.userIsAllowedToRate) {
      final result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return RateAndCommentModal(
            recipeId: recipeId,
            recipeName: recipeName,
          );
        },
      ) as bool?;
      if (result ?? false) model!.userIsAllowedToRate = false;
      return;
    }
    return Navigator.pop(context);
  }
}
