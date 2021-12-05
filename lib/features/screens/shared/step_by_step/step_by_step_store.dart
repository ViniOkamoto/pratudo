import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'step_by_step_store.g.dart';

class StepByStepStore = _StepByStepStoreBase with _$StepByStepStore;

abstract class _StepByStepStoreBase with Store {
  final PageController pageController = PageController();

  @observable
  int page = 0;

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
  bool get hasSection {
    int currentlyStep = pageIntervals.keys.toList().indexOf(titlePage!);

    return currentlyStep < pageIntervals.length - 1;
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
}
